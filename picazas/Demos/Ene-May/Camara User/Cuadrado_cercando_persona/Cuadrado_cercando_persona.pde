
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector min = new PVector(0,0,0);
PVector max = new PVector(0,0,0);
int kinectWidth = 640;
int kinectHeight = 480;
float reScale;
int clickedDepth,clickPosition;

void setup(){
  size(900,600,P3D);
  background(0);
  reScale = (float) width / kinectWidth;
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){ print("X");
  background(0);
  min.x = width;
  min.y = height;
  max.x = 0;
  max.y = 0;
  
  kinect.update();  
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  PImage cam = createImage(640,480,RGB);

  if (kinect.getNumberOfUsers() > 0) {
    cam.loadPixels(); 
  for(int z = 0; z < userList.length; z++) {    
    for(int x = 0; x < 640; x++){           //See all the pixels
      for(int y = 0; y < 480; y++){ 
      
          int clickPosition = x + (y*640); 
          if (userMap[clickPosition] != 0) {
            cam.pixels[clickPosition] = color(255);
            if(x < min.x){
              min.x = x;
            }
            if(x > max.x){
              max.x = x;
            }
            if(y < min.y){
              min.y = y;
            }
            if(y > max.y){
              max.y = y;
            } 
          }
      }
     }
   }
    cam.updatePixels();
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam,0,0);
  }

    stroke(255);
    line(min.x,min.y,min.x,max.y);
    line(min.x,min.y,max.x,min.y);
    line(max.x,min.y,max.x,max.y);
    println("coor: " + min.x + " , " + min.y + " , " + max.x + " , " + max.y );
}

void mousePressed(){
  println("X: " + mouseX + "Y: " + mouseY);
}
