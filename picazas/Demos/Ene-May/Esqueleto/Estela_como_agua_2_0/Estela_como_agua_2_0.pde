
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector jointPosE = new PVector(0,0,0);
PVector jointPosP = new PVector(0,0,0);
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;
int clickedDepth,clickPosition;
int maxValue=2500;

void setup(){
  size(1000,650);
  background(0,255,0);
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
  
  for(int i=0;i<userList.length;i++)
 {
   int userId = userList [i];
   
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPosP);
  println("Neck:"+jointPosP);
      
}
  
  jointPosE.x = jointPosP.x;
  jointPosE.y = jointPosP.y;
  
    cam.loadPixels(); 
    for(int x = 0; x < 640; x++){           //See all the pixels
      for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
        if (clickedDepth > 455){
        if (maxValue > clickedDepth){
          cam.pixels[ clickPosition] = color(255);}
        else cam.pixels[ clickPosition] = color(0,255,0);
        }
      }
    }
    // display the changed pixel array
    cam.updatePixels(); 
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam,0,0); 
    fill(0,255,0,10);
    rect(0,0,width, height);
  
  for ( int h=0; h<20; h++){
    stroke(255,0,0);
    line(jointPosE.x,0,random(-50,width+50),random(-50,0));
    stroke(255,0,0);
    line(jointPosE.x,0,random(-50,width+50),random(height,height+50));
    stroke(255,0,0);
    line(jointPosE.x,0,random(-50,0),random(-50,height+50));
    stroke(255,0,0);
    line(jointPosE.x,0,random(width,width+50),random(-50,height+50));
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
  case 'q':
    maxValue += 100;
    break;
  case 'a':
    maxValue -= 100;
    break;
  }
  println("maxValue: " + maxValue);
}

