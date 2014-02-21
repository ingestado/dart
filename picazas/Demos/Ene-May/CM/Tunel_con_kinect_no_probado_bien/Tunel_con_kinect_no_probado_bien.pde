
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
int kinectWidth = 640;
int kinectHeight = 480;
color circle;
float reScale;
int[][] squares = new int [10][4];   //{x,y,z,activated}
PVector f = new PVector(0,0,0);
int begining = 1;
float div;
float angle = 0;

void setup(){
  size(800,600,P3D);
  background(255);
  div=height/width;
  reScale = (float) width / kinectWidth;
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  for(int s=0; s<10; s++){
    squares[s][0] = 0;
    squares[s][1] = 0;
    squares[s][2] = 0;
    squares[s][3] = 0;
  }
  
  squares[0][3] = 1;
  f.x = width/2;
  f.y = height/2;
  f.z = -width/2;
  
}

void draw(){
  kinect.update();
  int[] userList = kinect.getUsers();
  int[] userMap = kinect.userMap();
  PImage cam = createImage(640,480,RGB);
  background(0);
  
  
  for (int i=0; i<userList.length; i++){
    int userId = userList[i]; //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
              
    f.x = position.x*reScale;
    f.y = position.y*reScale;
      for(int s=0; s<10; s++){
        if(squares[s][3] == 1){
          
          if(f.x < width/2 && angle < 25){
            angle += 0.2;
            rotateY(radians(angle));
          }
          else if (f.x > width/2 && angle > -25){
            angle -= 0.2;
            rotateY(radians(angle));
          }
          translate(0,0,squares[s][2]);
          fill(0);
          strokeWeight(10);
          stroke(255);
          rect(squares[s][0],squares[s][1],(width-(2*squares[s][0])),(height-(2*squares[s][1])));
          
          squares[s][1]++;
          squares[s][0]+= 2;
          //squares[s][2]--;
                
          if((width-(2*squares[s][0]))<10){
            squares[s][3]=0;
          }
          
        }
        
        if(squares[s][3]==0 &&  begining==0){
            squares[s][0] = 0;
            squares[s][1] = 0;
            squares[s][2] = 0;
            squares[s][3]=1;
        }
      }
      if(begining == 1){
        int x = width/20;
        for(int r=0; r<10; r++){
          if(squares[0][0] == x*r){
            squares[r][3] = 1;
            squares[r][0] = 0;
            squares[r][1] = 0;
            squares[r][2] = 0;
          }
        }
      }
      if(squares[9][3]==1) {begining=0;}
      
      println(squares[9][3] +" , "+begining);
  }
}
  
  
