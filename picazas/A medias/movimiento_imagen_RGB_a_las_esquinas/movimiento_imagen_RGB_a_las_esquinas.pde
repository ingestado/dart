import SimpleOpenNI.*;
SimpleOpenNI  kinect;
import processing.opengl.*;

int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;
int clickedDepth,clickPosition;
int maxValue;
int XRGB = 0;
int YRGB = 0;
int activarRGB = 0;
PImage camRGB = createImage(640,480,RGB);;

void setup()
{
  size (1280, 720,OPENGL);
  kinect= new SimpleOpenNI(this);
  background(0);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB();
 
  maxValue = 2500;
}

void draw()
{
  // update the cam
  kinect.update();
  fill(0);
  rect(0,0,width,height);
  
  PImage camDepth = createImage(640,480,RGB);
  
  if(activarRGB == 0) {camRGB = kinect.rgbImage();; }
  
  int[] depthValues = kinect.depthMap();
  
  camDepth.loadPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        camDepth.pixels[ clickPosition] = color(255);}}
    }
  }
  camDepth.updatePixels();
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  if(activarRGB == 0) {//image(camRGB,XRGB,YRGB);
  XRGB +=20;
  YRGB -=20;
  //activarRGB = 1;
}
  image(camRGB,XRGB,YRGB);
  //image(camDepth,0,0);
}
  
void keyPressed(){
  switch(key)
  {
  case 'q':
    maxValue+=100;
    break;
  case 'a':
    maxValue-=100;
    break;
  }  
}  

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}
  
