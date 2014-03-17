// Which Face Is Which
// Daniel Shiffman
// April 25, 2011
// http://www.shiffman.net

class Blob {
  
  // A Rectangle
  Rectangle r;
  
  // Am I available to be matched?
  boolean available;
  
  // Should I be deleted?
  boolean delete;
  
  // How long should I live if I have disappeared?
  int timer = 127;
  
  // Assign a number to each face
  int id;
  
  // Make me
  Blob(int id, int x, int y, int w, int h) {
    r = new Rectangle(x,y,w,h);
    available = true;
    delete = false;
    this.id = id;
  }

  // Show me
  void display() {
    pushMatrix();
    pushStyle();
    noFill(); stroke(255,0,0);
    translate(r.x, r.y);
    rect(0,0,r.width, r.height);
    fill(255,0,0);
    rect(0,0, 15, 10);
    fill(0);
    text(id,0, 10);
    popStyle();
    popMatrix();
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  // Count me down, I am gone
  void countDown() {
    timer--;
  }

  // I am deed, delete me
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}

