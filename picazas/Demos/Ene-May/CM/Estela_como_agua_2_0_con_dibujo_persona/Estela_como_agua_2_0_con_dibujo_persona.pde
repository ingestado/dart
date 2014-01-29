
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector jointPos = new PVector(0,0,0);
PVector position = new PVector();
color c = color(255);
color w = color(0, 255, 0);
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;

void setup(){
  size(1000,600,P3D);
  background(0,255,0);
  reScale = (float) width / kinectWidth;
  maxValue = 2500;
  
  if (kinect.isInit()==false){
   println("Conectame por favor");
   exit();
   return; 
  }

  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  println("FUNCIONANDO");
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  PImage cam = createImage(640,480,RGB);
  int[] depthValues = kinect.depthMap();
  
  cam.loadPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        cam.pixels[ clickPosition] = color(c);}
      else cam.pixels[ clickPosition] = color(w);
    }
    }
  }
  cam.updatePixels();
  

 
  for (int i=0; i<userList.size(); i++){
    
    int userId = userList.get(i); //getting user data
    kinect.getCoM(userId, position);
    kinect.convertRealWorldToProjective(position, position);
    println("userId: " + userId);
    println("position: " + position.x + ", " + position.y + ", " + position.z);
    
    fill(0,255,0,10);
    rect(0,0,width, height);
    jointPos.x = position.x*reScale;
    jointPos.y = 0;
    
    for ( int h=0; h<40; h++){
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(-50,width+50),random(-50,0));
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(-50,width+50),random(height,height+50));
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(-50,0),random(-50,height+50));
      fill(255,0,0);
      line(jointPos.x,jointPos.y,random(width,width+50),random(-50,height+50));
    }
  }
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);
}
