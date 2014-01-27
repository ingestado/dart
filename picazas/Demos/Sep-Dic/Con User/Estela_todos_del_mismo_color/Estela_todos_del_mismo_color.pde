
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
PVector jointPos = new PVector();

void setup(){
  size (640,480);
  kinect= new SimpleOpenNI(this);
  background(0);
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableUser();
  
}

void draw(){
  kinect.update();
  fill(0,0,0,35);
  rect(0,0,640,480);
  
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
  
  int[] userList = kinect.getUsers();
 for(int i=0;i<userList.length;i++)
 {
  kinect.getJointPositionSkeleton(i,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);
}
  
  println("left hand:"+jointPos);
  
  fill(255,0,0);
  ellipse(jointPos.x,jointPos.y,20,20);
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
