
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector min = new PVector(0,0,0);
PVector max = new PVector(0,0,0);
PVector CM = new PVector(0,0,0);
PVector P1 = new PVector(0,0,0);
PVector P2 = new PVector(0,0,0);
PVector oldCM = new PVector(0,0,0);
PVector oldP1 = new PVector(0,0,0);
PVector oldP2 = new PVector(0,0,0);
int[][] lines;
int c;
int nLines = 150;
int kinectWidth = 640;
int kinectHeight = 480;
int tipe = 0;
float reScale;

void setup(){
  size(1000,600);
  background(255);
  reScale = (float) width / kinectWidth;
  
  c = width/nLines;
  lines = new int[nLines][2];
  for(int r=0; r<nLines; r++){
    lines[r][0] = int(random( (c*r)-25, (c*r)+25 ));
    lines[r][1] = int(random( (c*r)-25, (c*r)+25 ));
  }
  
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
  
  fill(0,0,0,35);
  rect(0,0,width,height);
  min.x = width;
  min.y = height;
  max.x = 0;
  max.y = 0;
  
  for (int i=0; i<userList.length; i++){
    cam.loadPixels();
    CM(i);
    
       for(int x = 0; x < 640; x++){           //See all the pixels
        for(int y = 0; y < 480; y++){ 
        
            int clickPosition = x + (y*640); 
            if (userMap[clickPosition] != 0) {
              cam.pixels[clickPosition] = color(255);
              if(x < min.x){
                min.x = x;
                P1.x = x;
                P1.y = y;
              }
              if(x > max.x){
                max.x = x;
                P2.x = x;
                P2.y = y;
              }
            }
         }
       }
    
    if((max.x-min.x) > 250){
      println(CM.x+" ; "+CM.y);
      lanzaCuerdas(int(P1.x),int(P1.y),int(P2.x),int(P2.y),int(CM.x),int(CM.y));
    }        
  }
  cam.updatePixels();
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);
  fill(255,0,0);
  ellipse(CM.x,CM.y,15,15);  
}

public void CM(int i){
  int[] userList = kinect.getUsers();
  int[] userMap = kinect.userMap();
  int userId = userList[i]; //getting user data
  kinect.getCoM(userId, position);
  kinect.convertRealWorldToProjective(position, position);      
  CM.x = position.x;//*reScale;
  CM.y = position.y;//*reScale;  
}

void lanzaCuerdas(int x1, int y1, int x2, int y2, int cmx, int cmy){
  int CMX = int(cmx*reScale);
  int CMY = int(cmy*reScale);
  fill(0,0,255);
  ellipse(CMX,CMY,15,15);
  println("CM:"+cmx+" ; "+CMY);
  if(abs(x2-cmx)>150){
    int X = width+int(random(-30,30));
    int Y = int(((width-x2)*(CMY-(height-CMY)/2)/x2))+int(random(-30,30));
    stroke(255);
    line(CMX,(cmy-40),3*x2,cmy-3*(cmy-y2));
  }
  if(abs(x1-cmx)>150){
    int X = int(random(-30,30));    
    int Y = int((cmx*(CMY-(height-CMY)/2))/(cmx-x1))+int(random(-30,30));
    stroke(255);
    line(CMX,(cmy-40),3*x1,cmy-3*(cmy-y1));
  }
}
