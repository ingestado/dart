import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
int cuentapos=0;
int position=-1;

void setup(){
  size(640,480);
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
    for (int i = 0; i < userMap.length; i++) { 
      // if the current pixel is on a user
      if (userMap[i] != 0) {
        // make it green
        pixels[i] = color(0, 255, 0); //The color you want for all pleople
      }
    }
    
    // display the changed pixel array
    updatePixels(); 
  }
  
}

