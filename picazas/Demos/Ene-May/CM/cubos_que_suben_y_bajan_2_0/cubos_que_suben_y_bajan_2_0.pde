
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] pos = new int [14][2];    //{x,y}
PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
PImage square;
int kinectWidth = 640;
int kinectHeight = 480;
float reScale;

void setup(){
  size(640,480,P3D);
  background(0);
  square = createImage(width/14,width/14,ARGB);
  reScale = (float) width / kinectWidth;

  for(int i = 0; i < square.pixels.length; i++) {
    float a = map(i, 0, square.pixels.length, 255, 0);
    square.pixels[i] = color(255, 255, 255, a); 
  }

  for( int u=0; u<14; u++){
    pos[u][0] = int(u*width/14.2);
    pos[u][1] = 0;
  }
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  fill(0);
  rect(0,0,width,height);
    
  for (int i=0; i<userList.size(); i++){
    int userId = userList.get(i); //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
      
    jointPos.x = position.x*reScale;
    jointPos.y = position.y*reScale;
    
    for( int u=0; u<14; u++){
      int min = u * width/14;
      int max = (u+1) * width/14;
      
         if(jointPos.x<max && jointPos.x>min){
           if(pos[u][1]>-1){
             pos[u][1]--;
           }
         }
         else{
           if(pos[u][1] < height-width/14){
           pos[u][1]++;
           }
         }
    }
    
  }
  
  for( int u=0; u<14; u++){
    image(square,pos[u][0],pos[u][1]);
     //drawSquare(pos[u][0],pos[u][1],width/7,width/7);
  }
}

/*void drawSquare (int x, int y, int w, int h){
  int [] square = new int [4];
  for(int z=0; z<20; z++){
    square[0] = x;
    square[1] = y + (h/2) - (z*h/20);
    square[2] = x+w;
    square[3] = y + (h/2);
    fill(255,255,255,15);
    noStroke();
    rectMode(CORNERS);
    rect(square[0],square[1],square[2],square[3]);
    square[0] = x;
    square[1] = y + (h/2);
    square[2] = x+w;
    square[3] = y + (h/2) + (z*h/20);
    fill(255,255,255,15);
    noStroke();
    rectMode(CORNERS);
    rect(square[0],square[1],square[2],square[3]);
  }
}*/
