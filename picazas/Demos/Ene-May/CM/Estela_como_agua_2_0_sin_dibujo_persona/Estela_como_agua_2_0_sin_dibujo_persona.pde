
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PImage cam = createImage(640,480,RGB);
PVector jointPos = new PVector(0,0,0);
PVector position = new PVector();
color c = color(255, 0, 0);
float reScale;
int kinectWidth = 640;
int kinectHeight = 480;

void setup(){
  size(1000,600,P3D);
  background(0,255,0);
  reScale = (float) width / kinectWidth;

  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  println("FUNCIONANDO");
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  for (int i=0; i<userList.size(); i++){
    
    int userId = userList.get(i); //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
    println("userId: " + userId);
    println("position: " + position.x + ", " + position.y + ", " + position.z);
    
    fill(0,255,0,10);
    rect(0,0,width, height);
    jointPos.x = position.x*reScale;
    jointPos.y = 0;
    
    for ( int h=0; h<20; h++){
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(-50,width+50),random(-50,0));
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(-50,width+50),random(height,height+50));
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(-50,0),random(-50,height+50));
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(width,width+50),random(-50,height+50));
    }
  }
}
