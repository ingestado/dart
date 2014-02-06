
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector(0,0,0);
PVector jointPos = new PVector(0,0,0);
int kinectWidth = 640;
int kinectHeight = 480;
float reScale;
float max_distance;

void setup() {
  size(700, 500,P3D); 
  background(0);
  reScale = (float) width / kinectWidth;
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  noStroke();
  max_distance = dist(0, 0, width, height);
}

void draw() 
{
  background(0);
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
 
  for (int z=0; z<userList.size(); z++){
    
    int userId = userList.get(z);           //getting user data    
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
      
    jointPos.x = position.x*reScale;
    jointPos.y = position.y*reScale;    
    
    for(int i = 0; i <= width; i += 20) {
      for(int j = 0; j <= height; j += 20) {
        float size = dist(jointPos.x, jointPos.y, i, j);
        size = size/max_distance * 66;
        ellipse(i, j, size, size);
      }
    }
  }      //for ends
  
}
