import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
int[][] x = new int [6][20];
int[][] y = new int [6][20];
int[][] vx = new int [6][20];
int[][] vy = new int [6][20];
int[][] iniciar = new int [6][20];
int kinectWidth = 640;
int kinectHeight = 480;
float reScale;

void setup(){
  size(1000,600);
  background(255);
  reScale = (float) width / kinectWidth;
  
  for(int r=0; r<6; r++){
    for(int u=0; u<20; u++){
      x[r][u] = -5;
      y[r][u] = -5;
      vx[r][u] = 0;
      vy[r][u]= 0;
      iniciar[r][u] = 0;
    }
  }
  
  /*if (kinect.isInit()==false){
   println("Conectame por favor");
   exit();
   return; 
  }*/

  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  //println("FUNCIONA");
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  fill(255,255,255,20);
  rect(0,0,width,height);
  
  
  for (int i=0; i<userList.size(); i++){
    for(int k=0; k<20; k++){
      int userId = userList.get(i); //getting user data
      kinect.getCoM(userId, position);
      kinect.convertRealWorldToProjective(position, position);
      
      jointPos.x = position.x*reScale;
      jointPos.y = position.y*reScale;
      x[i][k] += vx[i][k];
      y[i][k] += vy[i][k];
      fill(200,0,0);
      ellipse(x[i][k],y[i][k],2,2);
      
      if(iniciar[i][k] == 0){
        x[i][k] = int(jointPos.x);
        y[i][k] = int(jointPos.y);
        vx[i][k] = int(random(3,5))*((-1)*int(random(1,3)));
        vy[i][k] = int(random(3,5))*((-1)*int(random(1,3)));
        iniciar[i][k] = 1;
      }
      
      if(x[i][k]+1 > jointPos.x+100){
        vx[i][k] = int(random(3,5))*(-1);
      }
      else if(x[i][k]-1 < jointPos.x-100){
        vx[i][k] = int(random(3,5));
      }
      else if(y[i][k]+1 > jointPos.y+100){
        vy[i][k] = int(random(3,5))*(-1);
      }
      else if(y[i][k]-1 < jointPos.y-100){
        vy[i][k] = int(random(3,5));
      }
    }
  }
}
