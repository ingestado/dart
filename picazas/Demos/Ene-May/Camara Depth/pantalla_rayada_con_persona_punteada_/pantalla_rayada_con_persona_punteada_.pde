import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
int cuentay=0;
int cuentaYTotal=0;
int cuentapos=0;
int position=-1;
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;

void setup(){
  size(640,480,P3D);
  background(255);
  kinect= new SimpleOpenNI(this);
 
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();  
  maxValue = 2400;
  kinect.enableUser();  
}

void draw(){
  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  
  if(cuentapos==2){
    
    background(255);
    for(int y=0;y<500;y++){
      position++;
      
      cuentapos=0;
      if(cuenta<10){
        fill(0);
        line(0,position,640,position);
        cuenta++;
      }
      if(cuenta<20){ cuenta++;} 
      else {cuenta=0; }
      }
      
    position=0;
    
    }  
  else {cuentapos++;}
  
  if (kinect.getNumberOfUsers() > 0) { 

    // find out which pixels have users in them
    int[] userMap = kinect.userMap(); 

    // populate the pixels array
    // from the sketch's current contents
    cam.loadPixels(); 
    
    for (int y = 0; y < height; y++) { 
      if(cuentay==5){cuentay=0;}
      else{cuentay++;}
      cuentaYTotal++;
      for (int x = 0; x < width; x++) { 
      int i= x + x*cuentaYTotal;
        if(userMap[i] != 0){           // if the current pixel is on a user
          if (cuentay==5) {
            // make it green
            pixels[i] = color(0, 255, 0); //The color you want for all pleople
          }else {pixels[i] = color(0, 0, 255);}
        } 
      }
    }
    cuentaYTotal=0;
    // display the changed pixel array
    cam.updatePixels(); 
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam,0,0);
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


void keyPressed()
{
  switch(key)
  {
  case ' ':
    kinect.setMirror(!kinect.mirror());
    break;
  }
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
