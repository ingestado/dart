import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
int cuenta2=0;
int cuentay=0;
int cuentaYTotal=0;
int cuentapos=0;
int cuentapos2=0;
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
    loadPixels(); 
    if(cuentapos2==2){
    
    background(0);

   for(int y=0;y<500;y++){
     cuenta2++;
     for(int x=0;x<640;x++){
        
      cuentapos2=0;
      if(cuenta2<10){
        fill(255);
        point(x,y);
        
      }
      if(cuenta2<=20){ cuenta2=0;} 
     }  }
   }
  else {cuentapos2++;}
  
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

