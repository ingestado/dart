import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;

float rotation = 0;

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
  rotateY(radians(rotation));
  rotation++;
  translate(0,0,1000);
  stroke(255);
  
  PVector[] depthPoints = kinect.depthMapRealWorld();
  for (int i = 0; i < depthPoints.length;i+=10){
  PVector currentPoint = depthPoints[i];
  point (currentPoint.x,currentPoint.y,currentPoint.z); 
  }
}

