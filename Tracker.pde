class Tracker {
  int maxMove;
  int ttl;
  ArrayList<Blob> blobs;
  int minArea, maxArea;
  int numBlobs;

  Tracker(int maxMove, int ttl, int minArea, int maxArea) {
    this.ttl = ttl;
    this. maxMove = maxMove;
    this.minArea = minArea;
    this.maxArea = maxArea;

    blobs = new ArrayList<Blob>();
  }
  
  void draw(){
    for(Blob b : blobs){
      b.display();
    }
  }

  void update(Rectangle[] rects) {
    // if there's no blobs yet, add them all
    if (blobs.size() == 0) {
      for (int i = 0; i < rects.length; i++) {
        Rectangle r = rects[i];

        int a = r.width * r.height;
        if (a < maxArea && a > minArea) {     
          blobs.add(new Blob(numBlobs, r.x, r.y, r.width, r.height));
          numBlobs++;
        }
      }
    } 
    else if (blobs.size() <= rects.length) {
      boolean[] used = new boolean[rects.length];
      for (Blob b : blobs) {
        // Find rects[index] that is closest to Blob b
        // set used[index] to true so that it can't be used twice
        float record = 50000;
        int index = -1;
        for (int i = 0; i < rects.length; i++) {
          Rectangle r = rects[i];
          float d = dist(r.x, r.y, b.r.x, b.r.y);
          if (d < record && !used[i]) {
            record = d;
            index = i;
          }
        }
        used[index] = true;
        b.update(rects[index]);
      }
      for (int i = 0; i < rects.length; i++) {
        if (!used[i]) {
          Rectangle r = rects[i];
          blobs.add(new Blob(numBlobs, r.x, r.y, r.width, r.height));
          numBlobs++;
        }
      }
    } 
    else {
      for (Blob b : blobs) {
        b.available = true;
      }
      for (int i = 0; i < rects.length; i++) {
        // Find face object closest to faces[i] Rectangle
        // set available to false
        float record = 50000;
        int index = -1;
        for (int j = 0; j < blobs.size(); j++) {
          Blob b = blobs.get(j);
          Rectangle r = rects[i];
          float d = dist(r.x, r.y, b.r.x, b.r.y);
          if (d < record && b.available) {
            record = d;
            index = j;
          }
        }
        // Update Face object location
        Blob b = blobs.get(index);
        b.available = false;
        b.update(rects[i]);
      }
      for (Blob b : blobs) {
        if (b.available) {
          b.countDown();
          if (b.dead()) {
            b.delete = true;
          }
        }
      }
    }

    for (int i = blobs.size()-1; i >= 0; i--) {
      Blob b = blobs.get(i);
      if (b.delete) {
        blobs.remove(i);
      }
    }
  }
}

