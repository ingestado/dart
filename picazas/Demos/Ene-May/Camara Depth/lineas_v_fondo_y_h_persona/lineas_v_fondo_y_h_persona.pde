
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int total =80;
int lineW;
int c=0;
int c2=0;
int act=0;
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;

void setup(){
  size(1000,650);
  background(0);
  kinect= new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
  lineW = width/total;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();  
  maxValue = 2400;
}

void draw(){
  
  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  
  cam.loadPixels();
  for(int y = 0; y < 480; y++){
    
    if(c2<lineW){
      act=1;
      c2++;
    }
    else if(c2<(lineW*2)){
      act=2;
      c2++;
    }
    if(c2==(2*lineW-1)) {c2=0;}
    
    for(int x = 0; x < 640; x++){         //See all the pixels    
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
        if (maxValue > clickedDepth){
          if(act==1){
              cam.pixels[clickPosition] = color(255);
            }
            else if(act==2){
              cam.pixels[clickPosition] = color(0);
            }
        }
      }
    }
  }
  cam.updatePixels();

  fill(255);
  rect(0,0,width,height);
  for(int r=0; r<(total+1); r++){
    if(c==1){
      c=0;
      fill(0);
      noStroke();
      rect((lineW*r),-20,lineW,(height+40));
    }
   else if(c==0){c=1;}
  }
  c=0; 
  c2=0;
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);

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
