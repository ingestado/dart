import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuentay=0;
int cuentaYTotal=0;
int position=-1;
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

void setup(){
  size(1280,720,P3D);
  background(255);
  kinect= new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.enableDepth();
  kinect.enableUser();  
}

void draw(){
  kinect.update();
  background(255);
  
  if (kinect.getNumberOfUsers() > 0) { 

    // find out which pixels have users in them
    int[] userMap = kinect.userMap(); 
    PImage cam = createImage(640,480,RGB);

    // populate the pixels array
    // from the sketch's current contents
    cam.loadPixels(); 
    
    for (int y = 0; y < 479; y++) { 
      if(cuentay==5){cuentay=0;}
      else{cuentay++;}
      cuentaYTotal++;
      for (int x = 0; x < 639; x++) { 
      int i= x + x*cuentaYTotal;
        if(userMap[i] != 0){           // if the current pixel is on a user
          if (cuentay<5) {
            // make it green
            cam.pixels[i] = color(0, 255, 0); //The color you want for all pleople
          }
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

