
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[] array1 = new int [307200];
int[] array2 = new int [307200];
int num = 0;
int count = 0;
int act = 0;
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;
int clickedDepth,clickPosition;
int maxValue;

void setup(){
  size (800, 500,P3D);
  kinect= new SimpleOpenNI(this);
  background(0);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  for(int o=0; o<307200; o++){
    array1[o] = 0;
    array2[o] = 0;
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();
  maxValue = 2500;
}

  void draw(){

  kinect.update();
  fill(0,0,0,30);
  rect(0,0,width,height);
  
  PImage cam = createImage(640,480,RGB);

  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  cam.loadPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
        if (maxValue > clickedDepth){
          array2 [clickPosition] = 1;
          cam.pixels[ clickPosition] = color(175);
        }
        else array2 [clickPosition] = 0;
      }
    }
  }
  cam.updatePixels();
  
  for(int r=0; r<307200; r++){
    if(array1[r] != array2[r]){
      num++;
    }
  }
//  num = int(num*reScale);
  
  println("flujo optico: " + num);
 /* translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);*/
  
  if(num > 20000 && act==0){
    act=1;
  }
  
  if(act==1 && count==0){
    fill(255);
    noStroke();
    rect(0,0,width,height);
    stroke(0,0,50);
    strokeWeight(10);
    line(int(random(0,width)),0,0,int(random(0,height)));
    line(int(random(0,width)),height,width,int(random(0,height)));
    line(int(random(0,width)),0,int(random(0,width)),height);
    line(0,int(random(0,height)),width,int(random(0,height)));
    line(int(random(0,width)),0,0,int(random(0,height)));
    count++;
  }
  
  if(count == 4){
    count=0;
    act=0;
  }
  
  for(int r=0; r<307200; r++){
    array1[r] = array2[r];
  }
  num = 0;
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
