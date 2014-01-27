
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int currentUser = 1;
int userCount;
int x=0;
int y=0;
int t=0;
int cuenta=0;
PVector jointPos = new PVector();
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
float reScale;


void setup(){
  size (1000,500,P3D);
  kinect= new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
  background(0);
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
}

void draw(){
  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  userCount = kinect.getNumberOfUsers();
  PVector pos = new PVector();
  PVector posProjected = new PVector();
  kinect.getCoM(currentUser, pos); 
  kinect.convertRealWorldToProjective(pos, posProjected);
  if (pos.x != 0 && pos.z != 0 && pos.y != 0) {
    println("pos.x: " + pos.x);
    println("pos.y: " + pos.y);
    println("pos.z: " + pos.z);
    fill(0,255,0);

  }
  else println("Nada");
  
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  
  //image(kinect.userImage(),0,0);
  
  fill(0,0,0,35);
  rect(0,0,640,480);
  
  if (kinect.getNumberOfUsers() > 0) { 

    // find out which pixels have users in them
    

    // populate the pixels array
    // from the sketch's current contents
    cam.loadPixels(); 
    
    for (int i = 0; i < userMap.length; i++) { 
      // if the current pixel is on a user
      for(int z = 0; z < userList.length; z++) { 
      if(userList[z]==0){
      if (userMap[i] != 0) {
        // make it green
        pixels[i] = color(0, 255, 0); //The color you want for all pleople
      }
    }
    
    else if(userList[z]==1){
      if (userMap[i] != 0) {
        // make it green
        pixels[i] = color(255, 0, 0); //The color you want for all pleople
      }
    }
    
    else if(userList[z]==2){
      if (userMap[i] != 0) {
        // make it green
        pixels[i] = color(0, 0, 255); //The color you want for all pleople
      }
    }
    
      else if(userList[z]==3){
        if (userMap[i] != 0) {
          // make it green
          pixels[i] = color(255, 255, 255); //The color you want for all pleople
        }
      } 
    }   

  }
    
    cuenta++;
    if (cuenta==30){ 
      cuenta=0;
    println(t);
    t++;}
    // display the changed pixel array
    cam.updatePixels();
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam,0,0); 
    ellipse(pos.x,pos.y,20,20);
  }
  
  
 for(int i=0;i<userList.length;i++)
 {
  kinect.getJointPositionSkeleton(i,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);
}
  
  //println("left hand:"+jointPos);
  
}

