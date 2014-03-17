import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;
ArrayList<Contour> contours;

Tracker tracker;
Rectangle[] faces;

PImage thresh;

  int minArea = 200;
  int maxArea = (640 * 480) / 2;

void setup(){
  video = new Capture(this, 640, 480);
  size(video.width, video.height, P2D);
  opencv = new OpenCV(this, video.width, video.height);
    opencv.loadCascade(OpenCV.CASCADE_EYE);  

  thresh = createImage(opencv.width, opencv.height, ARGB);
  
  contours = new ArrayList<Contour>();
  tracker = new Tracker(50, 50, minArea, maxArea);
  
  video.start();
}

void draw(){
  if(video.available()){
    video.read();
    opencv.loadImage(video);
    int t = (int)map(mouseX, 0, width, 0, 255);
    println("thresh: " + t);
    faces = opencv.detect();
    tracker.update(faces);
    
  }
  image(opencv.getOutput(), 0,0);
  
  noFill();
  
  int numContours = 0;
  
  tracker.draw();
}



