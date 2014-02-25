
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
int[] linesPos = new int[19];
int tipe = 1;
int n = 0;
int s = 1;
int total = 19;
int kinectWidth = 640;
int kinectHeight = 480;
float angle = 0.0;
float reScale;


void setup(){
  size(900,600,P3D);
  background(0);
  reScale = (float) width / kinectWidth;
  
  n = width/15;
  int f = total-4;
  for(int x=0; x<f; x++){
    linesPos[x] = (n*x)+30-width/2;
  }
  linesPos[15] = 30-width/2-120;
  linesPos[16] = 30-width/2-60;
  linesPos[17] = 870-width/2+60;
  linesPos[18] = 870-width/2+120;
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){ 
  println("Tipe: " + tipe);
  kinect.update();
  background(0);
  
  translate(width/2,0,30);
  rotateY(radians(angle));
  for(int x=0; x<total; x++){
    
    fill(255);
    stroke(0,0,255);
    rect((linesPos[x]-5),-500,10,(height+1000));
    
  }
  
  switch(tipe){
    case 1:
      
      if(angle > 25 || angle < -25){
        s = s*(-1);
      }
      if(s==1){
        angle += 0.2;
      }
      else angle -= 0.2;
      
      break;
      
    case 2:
        
       int[] userList = kinect.getUsers();
       int[] userMap = kinect.userMap();
       PImage cam = createImage(640,480,RGB);
       
       for (int i=0; i<userList.length; i++){
         int userId = userList[i]; //getting user data
         kinect.getCoM(userId, position);
         kinect.convertRealWorldToProjective(position, position);
              
         jointPos.x = position.x*reScale;
         jointPos.y = position.y*reScale;
            
         /*cam.loadPixels(); 
          for(int z = 0; z < userList.length; z++) {    
            for(int x = 0; x < 640; x++){           //See all the pixels
              for(int y = 0; y < 480; y++){         
                  int clickPosition = x + (y*640); 
                  if (userMap[clickPosition] != 0) {
                    cam.pixels[clickPosition] = color(255);
                  }
               }
             }
           }
           cam.updatePixels();
           translate(0, (height-kinectHeight*reScale)/2);
           scale(reScale);
           image(cam,0,0);*/
           
           if(jointPos.x<(width/2)){
             angle += 0.2;
           }
           else angle -= 0.2;
       }
     
     break;
        
  }
  
  if (keyPressed) {
    if (key == 'a') {
      tipe = 1;
    }
    if (key == 'b') {
      tipe = 2;
    }
  }
  
}
