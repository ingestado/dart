import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup(){
  size (640,480,OPENGL);
  kinect = new SimpleOpenNI (this);
  kinect.enableDepth();
}

void draw(){
  background(0);
  kinect.update();
  translate(width/2,height/2,-1000);
  rotateX(radians(180));
  stroke(255);
  
  PVector[] depthPoints = kinect.depthMapRealWorld();
  for (int i = 0; i < depthPoints.length;i++){
  PVector currentPoint = depthPoints[i];
  point (currentPoint.x,currentPoint.y,currentPoint.z); 
  }
}

