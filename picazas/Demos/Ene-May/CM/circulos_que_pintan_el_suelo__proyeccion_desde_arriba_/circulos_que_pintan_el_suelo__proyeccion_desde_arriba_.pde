
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
int kinectWidth = 640;
int kinectHeight = 480;
color circle;
float reScale;


void setup(){
  size(900,600,P3D);
  background(0);
  reScale = (float) width / kinectWidth;
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){ 
  kinect.update();
  int[] userList = kinect.getUsers();
  int[] userMap = kinect.userMap();
  PImage cam = createImage(640,480,RGB);
       
  for (int i=0; i<userList.length; i++){
    int userId = userList[i]; //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
              
    jointPos.x = position.x*reScale;
    jointPos.y = position.y*reScale;
    
    switch(userId){
      case 1:
        circle = color(255);
        break;
      case 2:
        circle = color(0,0,255);
        break;
      case 3:
        circle = color(255,0,0);
        break;
      case 4:
        circle = color(0,255,0);
        break;
      case 5:
        circle = color(125,125,0);
        break;      
    }
    
    fill(circle);
    stroke(circle);
    ellipse(jointPos.x,jointPos.y,150,150);
  }
  
}
