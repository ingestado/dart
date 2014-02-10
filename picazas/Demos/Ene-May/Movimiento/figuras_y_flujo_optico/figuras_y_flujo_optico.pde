import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector c1 = new PVector (0,0,0);
PVector c2 = new PVector (250,0,0);
PVector c3;
PVector c4;
int[] array1 = new int [307200];
int[] array2 = new int [307200];
int num = 0;
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;
int clickedDepth,clickPosition;
int maxValue;

void setup(){
  size (800, 500);
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
  c3 = new PVector (width-25,height/2,0);
  c4 = new PVector (width/2,height/2,0);
  maxValue = 2500;
  
}


void draw()
{

  kinect.update();
  fill(0,0,0,35);
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
          cam.pixels[ clickPosition] = color(0, 200, 0);
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
  num = int(num*reScale);
  
  println("flujo optico: " + num);
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);
  
  fill(200,200,0);
  rect(c1.x,c1.y,25,height/2);
  fill(200,200,0);
  rect(c2.x,c2.y,100,height/2);
  fill(200,200,0);
  rect(c3.x,c3.y,25,height/2);
  fill(200,200,0);
  rect(c4.x,c4.y,100,height/2);
  
  int w = int(num / 4000) + 1;
  c1.x += w;
  if(c1.x > width) { c1.x = 0; }
  c2.x += w;
  if(c2.x > width) { c2.x = 0; }
  c3.x -= w;
  if(c3.x < 0) { c3.x = width; }
  c4.x -= w;
  if(c4.x < 0) { c4.x = width; }
  println(w);
  num = 0;
  for(int r=0; r<307200; r++){
    array1[r] = array2[r];
  }
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
