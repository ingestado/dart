
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
int top = 0;
int act = 0;
int kinectWidth = 640;
int kinectHeight = 480;
int maxValue = 2500;
float reScale;
int clickedDepth,clickPosition;

void setup(){
  size(1000,600);
  background(255);
  reScale = (float) width / kinectWidth;
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  fill(255,0,0);
  rect(0,0,width,height);
  
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
    
  cam.loadPixels();
   for(int x = 0; x < 640; x++){           //See all the pixels
     for(int y = 0; y < 480; y++){
       clickPosition = x + (y*640);        //We see which pixel we are working on
       clickedDepth = depthValues[clickPosition];    //See the pixel's value 
       if (clickedDepth > 455){
       if (maxValue > clickedDepth){
         cam.pixels[ clickPosition] = color(255);}}
     }
   }
   cam.updatePixels();
   
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);
  
  for (int i=0; i<userList.size(); i++){
    
      int userId = userList.get(i); //getting user data
      int[] userMap = kinect.userMap();
      kinect.getCoM(userId, position);
      kinect.convertRealWorldToProjective(position, position);

      fill(0,255,0);
      ellipse(position.x,position.y,15,15);
      
      top = int(position.y-(height - position.y));
      fill(0,0,255);
      ellipse(position.x,top,15,15);
      act = 1;
   }
   println("position.x " + position.x + " position.y " + position.y);
   println("top " + top + " jointPos.y " + jointPos.y);
    
}


void keyPressed(){
  
  println("MaxValue: " + maxValue);
  switch(key)
  {
  case 'q':
    maxValue+=100;
    break;
  case 'a':
    maxValue-=100;
    break;
  }  
}

void mousePressed(){
  println("X: " + mouseX + "Y: " + mouseY);
}
