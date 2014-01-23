//Pensado para una distancia de unos dos metros

import SimpleOpenNI.*;
import processing.opengl.*;
import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
SimpleOpenNI kinect;
PBox2D box2d;

ArrayList<Luz> luces;
int cuenta=0;
int cuenta2=0;
PVector jointPos = new PVector();

void setup(){
  size (640,480,OPENGL);
  kinect= new SimpleOpenNI(this);
  
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(0, 200);
  
  luces = new ArrayList<Luz>();
  Vec2 gravity = new Vec2(0,-10);
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.enableDepth();
  kinect.enableUser();
  background(0);
}

void draw(){
  kinect.update();
  box2d.step();
  background(0);
  
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
        pixels[i] = color(0, 255, 0); 
      }
    }
    
    // display the changed pixel array
    updatePixels(); 
  }
  
  int[] userList = kinect.getUsers();
 for(int i=0;i<userList.length;i++)
 {
   int userId = userList [i];
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);

  if (cuenta2==60){
  println("left hand:"+jointPos);
  cuenta2=0;
  } else cuenta2++;
  
    
  translate(320,240,0);
  rotateX(radians(180));
  jointPos.x = jointPos.x / 4;
  jointPos.y = jointPos.y / 4;
  
  if (cuenta==2){
    cuenta = 0;
    Luz p = new Luz(jointPos.x,jointPos.y);
    luces.add(p);
  }
  else { cuenta++;}
  
  for (Luz b: luces){
    b.display();
  }
  
  
  fill(255,0,0);
  ellipse(jointPos.x,jointPos.y,20,20);
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

