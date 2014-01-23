import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
int cuentay=0;
int cuentaYTotal=0;
int position=-1;

void setup(){
  size(640,480,P3D);
  background(255);
  kinect= new SimpleOpenNI(this);
  
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

    // populate the pixels array
    // from the sketch's current contents
    loadPixels(); 
    
    for (int y = 0; y < 479; y++) { 
      if(cuentay==5){cuentay=0;}
      else{cuentay++;}
      cuentaYTotal++;
      for (int x = 0; x < 639; x++) { 
      int i= x + x*cuentaYTotal;
        if(userMap[i] != 0){           // if the current pixel is on a user
          if (cuentay<5) {
            // make it green
            pixels[i] = color(0, 255, 0); //The color you want for all pleople
          }
        } 
      }
    }
    cuentaYTotal=0;
    // display the changed pixel array
    updatePixels(); 
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

