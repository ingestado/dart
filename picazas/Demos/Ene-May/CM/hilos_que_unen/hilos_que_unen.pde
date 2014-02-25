
import SimpleOpenNI.*;
SimpleOpenNI kinect;


PVector position = new PVector();
int[][] jointPos = new int[15][2];   //{person}{x,y}
int[] union = new int[15];
int kinectWidth = 640;
int kinectHeight = 480;
int max = 0;
float reScale;

void setup(){
  size(900,600);
  background(255);
  reScale = (float) width / kinectWidth;
  
  for(int r=0; r<6; r++){
    jointPos[r][0] = 0;
    jointPos[r][1] = 0;
  }
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  background(0);
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  for (int i=0; i<userList.size(); i++){
    int userId = userList.get(i); //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
      
    jointPos[i][0] = int(position.x*reScale);
    jointPos[i][1] = int(position.y*reScale);    
  }
  for (int i=0; i<userList.size(); i++){
    for(int r=0; r<6; r++){
      int x = jointPos[i][0]-jointPos[r][0];
      if(x!=0 && x<max){
        max = x;
        union[i] = r;        
      }
    }
    
    for(int r=0; r<6; r++){
      stroke(255);
      int q = jointPos[r][0]-jointPos[union[r]][0];
      int z = union[r];
      if(q>0){
        drawLines(jointPos[r][0],jointPos[r][1],jointPos[z][0],jointPos[z][1]);
      }
      else{
        drawLines(jointPos[z][0],jointPos[z][1],jointPos[r][0],jointPos[r][1]);
      }
    }
  }
  
}

void drawLines(int x1, int y1, int x2, int y2){
  for(int w=0; w<6; w++){
    int q = x2-x1;
    noFill();
    stroke(255);
    beginShape();
    curveVertex(x1-100,y1-w*25);
    curveVertex(x1,y1);
    curveVertex(x1+q/4,y1+w*25);
    curveVertex(x1+q/2,y1+1.3*w*25);
    curveVertex(x1+3*q/4,y1+w*25);
    curveVertex(x2,y2);
    curveVertex(x2+100,y2-w*25);
    endShape();
    noFill();
    stroke(255);
    beginShape();
    curveVertex(x1-100,y1+w*25);
    curveVertex(x1,y1);
    curveVertex(x1+q/4,y1-w*25);
    curveVertex(x1+q/2,y1-1.3*w*25);
    curveVertex(x1+3*q/4,y1-w*25);
    curveVertex(x2,y2);
    curveVertex(x2+100,y2+w*25);
    endShape();
  }
}
