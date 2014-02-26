
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector(0,0,0);
PVector jointPos = new PVector(600,400,0);
PVector jointPosLH = new PVector(0,0,0);
PVector jointPosRH = new PVector(0,0,0);
PVector p= new PVector (0,0);
int part = 0;
int a=0;
int comienzo = 0;
int cuentaPixels = 36000;
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue = 2500;
int radio;
int move = 0;
int cuenta2=0;
int goUp = 0;
int[] depthValues;
int[] depthValues2;
color c = color(255);
float reScale;
float max_distance;

void setup(){
  size(900, 600);
  background(0);
  reScale = (float) width / kinectWidth;
  max_distance = dist(0, 0, width, height);
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  radio = int(width*1.6);
  depthValues2 = kinect.depthMap();
  depthValues = kinect.depthMap();
  
}

void draw(){ 

  kinect.update();
  int[] userList = kinect.getUsers();
  PImage cam = createImage(640,480,RGB);
  
  println("Part: " + part);
  switch(part){
    
    case 0:
      background(0);
            
      for (int z=0; z<userList.length; z++){
        
        int userId = userList[z];           //getting user data    
        kinect.getCoM(userId, position);
        kinect.convertRealWorldToProjective(position, position);
          
        jointPos.x = position.x*reScale;
        jointPos.y = position.y*reScale;    
        
        for(int i = 0; i <= width; i += 20) {
          for(int j = 0; j <= height; j += 20) {
            float size = dist(jointPos.x, jointPos.y, i, j);
            size = size/max_distance * 66;
            fill(255);
            ellipse(i, j, size, size);
          }
        }
      }
      if(jointPos.x<width/10){ part++;}
      break;
      
    case 1:
    
      depthValues = kinect.depthMap();
      cam.loadPixels();
      for(int x = 0; x < 640; x++){           //See all the pixels
        for(int y = 0; y < 480; y++){
          clickPosition = x + (y*640);        //We see which pixel we are working on
          clickedDepth = depthValues[clickPosition];    //See the pixel's value 
          if (clickedDepth > 455){
            if (maxValue > clickedDepth){
              cuentaPixels++;
              cam.pixels[ clickPosition] = color(0);
            }
          }
        }
      }
      cam.updatePixels();
      
      if (cuentaPixels < 35000)  {
        comienzo = 1;
      }
      if (comienzo == 1){
        radio-=5;
        if(radio < 30){
          part++;
          radio=int(width*1.6);
          cuentaPixels = 0;
        }
      }
      
      println("Comienzo: " + comienzo);
      println("Pixels: " + cuentaPixels);
      cuentaPixels = 0;
      fill(0);
      rect(0,0,width,height);
      fill(255);
      ellipse(width/2,height-height/20,radio,radio);  
      translate(0, (height-kinectHeight*reScale)/2);
      scale(reScale);
      image(cam,0,0);
           
      break;
    
    case 2:
        depthValues = kinect.depthMap();
        fill(0);
        rect(0,0,width, height);
        
        
        for(int i=0;i<userList.length;i++)
         {
           int userId = userList [i];
           
          kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
          kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,jointPosLH);
          kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,jointPosRH);
          println("Neck:"+jointPos);
          println("left hand:" + jointPosLH);
          println("Right hand:" + jointPosRH);
              
        
  
      if(goUp == 0){
        if(jointPosLH.x < 0 && jointPosLH.y >0 && jointPosRH.x > 0 && jointPosRH.y >0){ 
          goUp = 1;
        }
      }
    
      if(goUp == 1){
        move+=10;
      }
      if(jointPos.x!=0){
        jointPos.x = (jointPos.x + 600)/2;
        jointPos.y = (jointPos.y - 400)/(-1.75);
      }
      else{
        kinect.getCoM(userId, position);
        kinect.convertRealWorldToProjective(position, position);
          
        jointPos.x = position.x*reScale;
        jointPos.y = position.y*reScale;
      }
      
      for ( int h=0; h<20; h++){
        translate(0,-move);
        stroke(c);
        line(jointPos.x,jointPos.y,random(-50,width+50),random(-50,0));
        translate(0,move);
        stroke(c);
        line(jointPos.x,jointPos.y - move,random(-50,width+50),random(height,height+50));
        stroke(c);
        line(jointPos.x,jointPos.y - move,random(-50,0),random(-50,height+50));
        stroke(c);
        line(jointPos.x,jointPos.y - move,random(width,width+50),random(-50,height+50));
      }
      }
       if (kinect.getNumberOfUsers() > 0) { 
    
        p.x=0;
        p.y=0;
        // populate the pixels array
        // from the sketch's current contents
        cam.loadPixels(); 
        for(int x = 0; x < 640; x++){           //See all the pixels
        for(int y = 0; y < 480; y++){
          clickPosition = x + (y*640);        //We see which pixel we are working on
          clickedDepth = depthValues[clickPosition];    //See the pixel's value 
          if (clickedDepth > 455){
          if (maxValue > clickedDepth){
            cam.pixels[ clickPosition] = color(0, 255, 0);}}
        }
      }
        
        // display the changed pixel array
        cam.updatePixels(); 
      }
    
      translate(0, (height-kinectHeight*reScale)/2);
      scale(reScale);
      image(cam,0,0);
      
      if(jointPos.y - move < -150){ part++; move=0;}
      
      break;
      
    case 3:
      fill(0,0,0,35);
      rect(0,0,width,height);
      cuentaPixels ++;
    
      depthValues2 = depthValues;
      cam.loadPixels();
    
      for(int x = 0; x < 640; x++){           //See all the pixels
        for(int y = 0; y < 480; y++){
          clickPosition = x + (y*640);        //We see which pixel we are working on
          clickedDepth = depthValues2[clickPosition];    //See the pixel's value 
          if (clickedDepth > 455){
          if (maxValue > clickedDepth){
            switch (a){
              case 0:
              
                cam.pixels[ clickPosition] = color(255, 0, 0);
                break;
              
              case 1:           
                cam.pixels[ clickPosition] = color(255, 125, 0);
                break;
                
              case 2:           
                cam.pixels[ clickPosition] = color(255, 255, 0);
                break;
                
              case 3:           
                cam.pixels[ clickPosition] = color(125, 255, 0);
                break;
                
              case 4: 
                cam.pixels[ clickPosition] = color(0, 255, 0);
                break;
              
              case 5:           
                cam.pixels[ clickPosition] = color(0, 255, 125);
                break;
                         
              case 6:           
                cam.pixels[ clickPosition] = color(0, 255, 255);
                break;
                         
              case 7:          
                cam.pixels[ clickPosition] = color(0, 125, 255);
                break;
              
              case 8:           
                cam.pixels[ clickPosition] = color(0, 0, 255);
                break;
                         
              case 9:           
                cam.pixels[ clickPosition] = color(125, 0, 255);
                break;
                          
              case 10:           
                cam.pixels[ clickPosition] = color(255, 0, 255);
                a=0;
                break;
              case 11:           
                cam.pixels[ clickPosition] = color(255, 0, 125);
                a=0;
                break;
                
          }
         }  
        }
       }
      }
      
      if (a==11) a=0;
      else  a++;
      
      depthValues = kinect.depthMap();  //Save the Depth's values in an array
      
      for(int x = 0; x < 640; x++){           //See all the pixels
        for(int y = 0; y < 480; y++){
          clickPosition = x + (y*640);        //We see which pixel we are working on
          clickedDepth = depthValues[clickPosition];    //See the pixel's value 
          if (clickedDepth > 455){
          if (maxValue > clickedDepth){
            cam.pixels[ clickPosition] = color(255);}
          }
        }
      }
      cam.updatePixels();
      translate(0, (height-kinectHeight*reScale)/2);
      scale(reScale);
      image(cam,0,0);
      
      if(cuentaPixels == 250){part=0;}
      
      break;
  }
  
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  curContext.startTrackingSkeleton(userId);
  println("looking for skeleton");
}



void keyPressed()
{
  
  switch(key)
  {
  case ' ':
    kinect.setMirror(!kinect.mirror());
    break;
  case 'q':
    maxValue += 100;
    break;
  case 'a':
    maxValue -= 100;
    break;
  case '+':
    part ++;
    break;
  case '-':
    part --;
    break;
  }
  println("maxValue: " + maxValue);
}
