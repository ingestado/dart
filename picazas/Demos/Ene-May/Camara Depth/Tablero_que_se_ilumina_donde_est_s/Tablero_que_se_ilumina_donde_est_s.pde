
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] square = new int [2][2]; //{Xi,Yi}{Xf,Yf}
int[] act = new int [60];
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;

void setup(){
  size(640,480,P3D);
  background(0);
  kinect= new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();  
  maxValue = 2500;
  for(int u=0; u<60; u++){act[u]=0;}
}

void draw(){

  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  
  fill(0);
  rect(-1,-1,width+1,height+1);
  stroke(255);
  line(0,height/6,width,height/6);
  line(0,height/3,width,height/3);
  line(0,height/2,width,height/2);
  line(0,height*2/3,width,height*2/3);
  line(0,height*5/6,width,height*5/6);
  line(width/10,0,width/10,height);
  line(width/5,0,width/5,height);
  line(width*3/10,0,width*3/10,height);
  line(width*2/5,0,width*2/5,height);
  line(width/2,0,width/2,height);
  line(width*3/5,0,width*3/5,height);
  line(width*7/10,0,width*7/10,height);
  line(width*4/5,0,width*4/5,height);
  line(width*9/10,0,width*9/10,height);
  
  cam.loadPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455 && maxValue > clickedDepth){
        
          cam.pixels[ clickPosition] = color(120,0,0);
        
          for(int cx=0; cx<10; cx++){
            for(int cy=0; cy<6; cy++){
              int x1 = int(cx*(width/10));
              int x2 = int((cx+1)*(width/10));
              int y1 = int(cy*(height/6));
              int y2 = int((cy+1)*(height/6));
              if( x>x1 && x<x2 && y>y1 && y<y2){
                int num = cx + cy*10;
                act[num] = 1;
              }
            }
          }
                 
        }
     }    
  }
  cam.updatePixels();
  
  for(int x = 0; x < 10; x++){
    for(int y = 0; y < 6; y++){
      int num = x + y*10;
      if(act[num] == 1){
         square[0][0] = int(x*width/10);      //XI
         square[1][0] = int((x+1)*width/10);  //XF
         square[0][1] = int(y*height/6);      //YI
         square[1][1] = int((y+1)*height/6);  //YF
    
         fill(255);
         rect(square[0][0],square[0][1],square[1][0],square[1][1]);
      }
    }
  }
  for(int u=0; u<60; u++){act[u]=0;}
  /*translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);*/
}

void keyPressed(){
  
  println("MaxValue: " + maxValue);
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
