import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue, closestX, closestY;
float lastX, lastY;
float imageX, imageY;
boolean imageMoving;
PImage photo;

void setup(){
  size (1280,480,P2D);
  kinect = new SimpleOpenNI (this);
  kinect.enableDepth();
  imageMoving = true;
  photo = loadImage("photo1.jpg");
  background (0);
}


void draw(){
  closestValue = 8000;
  kinect.update();
  int[] depthValues = kinect.depthMap();
  for (int x= 0; x<640; x++){
    for (int y= 0; y<480; y++){
      int reversedX = 640-x-1;
      int i = reversedX + y*640;
      int currentDepthValue = depthValues[i];
      if (currentDepthValue > 610 && currentDepthValue < closestValue
      && currentDepthValue<1525){
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }
  float interpolatedX = lerp(lastX, closestX, 0.3f);
  float interpolatedY = lerp(lastY, closestY, 0.3f);
  background(0);
  if (imageMoving){
    imageX = interpolatedX;
    imageY = interpolatedY;
  }
  image (kinect.depthImage(),640,0);
  image (photo,imageX,imageY);
  lastX = interpolatedX;
  lastY = interpolatedY;
}

void mousePressed(){
  fill(0);
  rect(0,0,640,480);
  imageMoving = !imageMoving;
}
