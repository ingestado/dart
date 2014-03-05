
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector CM = new PVector(0,0,0);
PVector min = new PVector(0,0,0);
PVector max = new PVector(0,0,0);
PVector P1 = new PVector(0,0,0);
PVector P2 = new PVector(0,0,0);
PVector P3 = new PVector(0,0,0);
PVector oldCM = new PVector(0,0,0);
PVector oldP1 = new PVector(0,0,0);
PVector oldP2 = new PVector(0,0,0);
PVector oldP3 = new PVector(0,0,0);
double visc, diff, vScale, velocityScale;
int numParticles;
int c = color(255);
int n;
int kinectWidth = 640;
int kinectHeight = 480;
float cellHeight; 
float cellWidth;
float  limitVelocity;
float reScale;
int clickedDepth,clickPosition;

Particle[] particles; 
Mov mov;

void setup(){
  size(900,600,P3D);
  frameRate(80);
  background(0);
  reScale = (float) width / kinectWidth;
  
  n = Mov.N;   //Number of triangles
  cellHeight = height / n;    //Size of each triangle
  cellWidth = width / n;
  
  mov = new Mov();
  numParticles = (int)pow(2, 16);      //2^16 = 65536 particles
  particles = new Particle[numParticles];
  visc = 0.00025f;
  diff = 0.03f;
  vScale = 3;
  velocityScale = vScale;  //Save the initial triangle scale 
  limitVelocity = 200;
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  initParticles();
}

void draw(){
  background(0);
  min.x = width;
  min.y = height;
  max.x = 0;
  max.y = 0;
  double dt = 1 / frameRate;
  
  kinect.update();  
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  PImage cam = createImage(640,480,RGB);

  if (kinect.getNumberOfUsers() > 0) {
    cam.loadPixels(); 
  for(int z = 0; z < userList.length; z++) {      
    
    int userId = userList[z]; //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
      
    CM.x = position.x*reScale;
    CM.y = position.y*reScale; 
    
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
              P3.x = x;
              P3.y = y;
            }
            if(y < min.y){
              min.y = y;
            }
            if(y > max.y){
              max.y = y;
              P2.x = x;
              P2.y = y;
            } 
          }
      }
     }
     
   }
    cam.updatePixels();
    for(int r=0; r<4; r++){
      handleMouseMotion(r); 
    }
    mov.tick(dt, visc, diff); 
    vScale = velocityScale * 60. / frameRate;
    drawParticlesPixels();
  }
}

private void handleMouseMotion(int s) {
  PVector P = new PVector(0,0,0);
  PVector oldP = new PVector(0,0,0);
  switch(s){
    case 0: P=CM; oldP=oldCM; break;
    case 1: P=P1; oldP=oldP1; break;
    case 2: P=P2; oldP=oldP2; break;
    case 3: P=P3; oldP=oldP3; break;
  }
  
  P.x = max(1, P.x);      //take highest value, 1 or mouseX.
  P.y = max(1, P.y);
 
  float pointDx = P.x - oldP.x;
  float pointDy = P.y - oldP.y;
  int cellX = floor(P.x / cellWidth);
  int cellY = floor(P.y / cellHeight);
 
  mov.applyForce(cellX, cellY, pointDx, pointDy);
 
  oldP.x = P.x;
  oldP.y = P.y;
  
  switch(s){
    case 0: oldCM=oldP; break;
    case 1: oldP1=oldP; break;
    case 2: oldP2=oldP; break;
    case 3: oldP3=oldP; break;
  }
}
