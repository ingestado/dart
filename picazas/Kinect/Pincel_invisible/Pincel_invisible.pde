import SimpleOpenNI.*;
SimpleOpenNI kinect;

int Ox;
int Nx;
int Oy;
int Ny;
int cuenta = 0;
float maxValue;

void setup(){
  fill(0);
  size (1280,480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw(){
  kinect.update();
  cuenta ++;
  maxValue = 8000;
  if (cuenta==60) { fill (0); rect(0,0,640,480);}
  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      int clickPosition = x + (y*640);        //We see which pixel we are working on
      int clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth == 470){
        fill(0);
        rect(0,0,640,480);}
      else if (clickedDepth > 500){
      if (maxValue > clickedDepth){
        maxValue = clickedDepth;      //If is the nearest pixel, we save its position
        Nx = x;
        Ny = y;}}
    }
  }
  
  PImage depthImage = kinect.depthImage();
  image(depthImage,640,0);        //Draw the depth image
  stroke (255);
  line (Ox,Oy,Nx,Ny);
  Ox = Nx;
  Oy = Ny;
}

void mousePressed (){
  background(0);}
