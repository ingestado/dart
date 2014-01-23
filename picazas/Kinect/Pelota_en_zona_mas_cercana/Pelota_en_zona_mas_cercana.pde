import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector p= new PVector (0,0);      //Create a vector to save the pixel's position
int clickedDepth,clickPosition;
int maxValue;

void setup () {
  size (640,480,P3D);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}


void draw () {
  kinect.update();
  maxValue = 8000;
  p.x=0;
  p.y=0;
  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        maxValue = clickedDepth;      //If is the nearest pixel, we save its position
        p.x = x;
        p.y = y;}}
    }
  }
  PImage depthImage = kinect.depthImage();
  image(depthImage,0,0);        //Draw the depth image
  fill(255,0,0);
  ellipse(p.x, p.y, 20, 20);    //Draw a red circle on the depth image
}
  
