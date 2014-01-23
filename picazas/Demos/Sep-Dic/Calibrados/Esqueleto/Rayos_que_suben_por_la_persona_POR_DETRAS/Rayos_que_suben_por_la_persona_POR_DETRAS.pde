import SimpleOpenNI.*;
SimpleOpenNI kinect;


int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;
int clickedDepth,clickPosition;
PVector jointPos = new PVector(0,0,0);
PVector jointPosLH = new PVector(0,0,0);
PVector jointPosRH = new PVector(0,0,0);
int move = 0;
int cuenta2=0;
int goUp = 0;
color c = color(255);
int maxValue=2500;
PVector p= new PVector (0,0);      //Create a vector to save the pixel's position

void setup(){
  size(1000,650);
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
  kinect.enableUser();
}


void draw(){
  
  kinect.update();
  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  int[] userList = kinect.getUsers();
  // find out which pixels have users in them
  PImage cam = createImage(640,480,RGB);
  fill(0);
  rect(0,0,width, height);
  
   for(int i=0;i<userList.length;i++)
 {
   int userId = userList [i];
   
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,jointPosLH);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,jointPosRH);
  println("Neck:"+jointPos);
  println("left hand:" + jointPosLH);
  println("Right hand:" + jointPosRH);
      
}

  if(goUp == 0){
    if(jointPosLH.x < 0 && jointPosLH.y >0 && jointPosRH.x > 0 && jointPosRH.y >0){ 
      goUp = 1;
    }
  }

  if(goUp == 1){
    move+=10;
  }

  jointPos.x = (jointPos.x + 1000)/2;
  jointPos.y = (jointPos.y - 570)/(-1.75);
  
  for ( int h=0; h<20; h++){
    translate(0,-move);
    stroke(c);
    line(jointPos.x,jointPos.y,random(-50,width+50),random(-50,0));
    translate(0,move);
    stroke(c);
    line(jointPos.x,jointPos.y - move,random(-50,width+50),random(height,height+50));
    stroke(c);
    line(jointPos.x,jointPos.y - move,random(-50,0),random(-50,height+50));
    stroke(c);
    line(jointPos.x,jointPos.y - move,random(width,width+50),random(-50,height+50));
  }
  
   if (kinect.getNumberOfUsers() > 0) { 

    p.x=0;
    p.y=0;
    // populate the pixels array
    // from the sketch's current contents
    cam.loadPixels(); 
    for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        cam.pixels[ clickPosition] = color(0, 255, 0);}}
    }
  }
    
    // display the changed pixel array
    cam.updatePixels(); 
  }

  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0); 
  
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
  case 'q':
    maxValue += 100;
    break;
  case 'a':
    maxValue -= 100;
    break;
  }
  println("maxValue: " + maxValue);
}

