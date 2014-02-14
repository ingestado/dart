
import SimpleOpenNI.*;
SimpleOpenNI kinect;

PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
PVector min = new PVector(0,0,0);
PVector max = new PVector(0,0,0);
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
  println(tipe);
  kinect.update();
  int[] userList = kinect.getUsers();
  int[] userMap = kinect.userMap();
  PImage cam = createImage(640,480,RGB);
  
  switch(tipe){
    case 0:
    
      fill(0,0,0,35);
      rect(0,0,width,height);
      
      for (int i=0; i<userList.length; i++){
        int userId = userList[i]; //getting user data
        kinect.getCoM(userId, position);
        kinect.convertRealWorldToProjective(position, position);
          
        jointPos.x = position.x*reScale;
        jointPos.y = position.y*reScale;
        
        for(int n=0; n<15; n++){
          PVector v = new PVector();
          v.x = int(random(jointPos.x-50,jointPos.x+50));
          v.y = int(random(jointPos.x-50,jointPos.x+50));
          PVector h = new PVector();
          h.x = int(random(jointPos.y-50,jointPos.y+50));
          h.y = int(random(jointPos.y-50,jointPos.y+50));
          stroke(255);
          line(v.x,0,v.y,height);
          line(0,h.x,width,h.y);
        }
      }
      
      
      break;
      
    case 1:
      
      background(0);
      min.x = width;
      min.y = height;
      max.x = 0;
      max.y = 0;
      
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
    
        for(int r=0; r<nLines; r++){
          int e = (c*r)-25;
          int u = (c*r)+25;
          lines[r][0] = int(random(e,u));
          lines[r][1] = int(random(e,u));
         }
        for(int w=0; w<nLines; w++){
          int s = lines[w][1] - lines[w][0] - ((lines[w][1]-lines[w][0])/2);
          if(lines[w][1]<max.x && lines[w][1]>min.x){
            if(lines[w][1]>(min.x+(max.x-min.x)/2)){
              stroke(255);
              line(lines[w][0],0,lines[w][1],min.y-50);
              noFill();
              beginShape();
              curveVertex(lines[w][1],(min.y)); 
              curveVertex(lines[w][1],(min.y-51)); 
              curveVertex((max.x+5+s),(min.y+100)); 
              curveVertex((max.x+30+s),(min.y+200));    
              curveVertex((max.x+30+s),(height-150)); 
              curveVertex((max.x+s),(height+40)); 
              curveVertex((max.x),(height+200));
              endShape();
            }
            else if(lines[w][1]<(min.x+(max.x-min.x)/2)){
              stroke(255);
              line(lines[w][0],0,lines[w][1],min.y-50);
              noFill();
              beginShape();
              curveVertex(lines[w][1],(min.y));
              curveVertex(lines[w][1],(min.y-51)); 
              curveVertex((min.x-5-s),(min.y+100)); 
              curveVertex((min.x-30-s),(min.y+200)); 
              curveVertex((min.x-30-s),(height-150)); 
              curveVertex((min.x-s),(height+40)); 
              curveVertex((min.x),(height+200));
              endShape();
            }
          } else  line(lines[w][0],0,lines[w][1],height);
        }
      }
      else {
       for(int r=0; r<nLines; r++){
          int e = (c*r)-25;
          int u = (c*r)+25;
          lines[r][0] = int(random(e,u));
          lines[r][1] = int(random(e,u));
          line(lines[r][0],0,lines[r][1],height);
         }         
      }            
      break;
      
    case 2:
    
       background(0);
       min.x = width;
       min.y = height;
       max.x = 0;
       max.y = 0;
          
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
      
          for(int r=0; r<nLines; r++){
            int e = (c*r)-25;
            int u = (c*r)+25;
            lines[r][0] = int(random(e,u));
            lines[r][1] = int(random(e,u));
           }
          for(int w=0; w<nLines; w++){
            int s = lines[w][1] - lines[w][0] - ((lines[w][1]-lines[w][0])/2);
            if(lines[w][1]<max.x && lines[w][1]>min.x){
              if(lines[w][1]>(min.x+(max.x-min.x)/2)){
                stroke(255);
                line(lines[w][0],0,lines[w][1],min.y-50);
                line(lines[w][1], (min.y-50), (max.x+5+s), (min.y+100));
                line((max.x+5+s),  (min.y+100), (max.x+30+s), (min.y+200));
                line((max.x+30+s), (min.y+200), (max.x+30+s), (height-150));
                line((max.x+30+s), (height-150), (max.x+s), (height+40));
              }
              else if(lines[w][1]<(min.x+(max.x-min.x)/2)){
                stroke(255);
                line(lines[w][0],0,lines[w][1],min.y-50);
                line(lines[w][1],(min.y-50),(min.x-5-s),(min.y+100));
                line((min.x-5-s),(min.y+100),(min.x-30-s),(min.y+200));
                line((min.x-30-s),(min.y+200),(min.x-30-s),(height-150));
                line((min.x-30-s),(height-150),(min.x-s),(height+40));
              }
            } else  line(lines[w][0],0,lines[w][1],height);
          }
       }
       else {
         for(int r=0; r<nLines; r++){
            int e = (c*r)-25;
            int u = (c*r)+25;
            lines[r][0] = int(random(e,u));
            lines[r][1] = int(random(e,u));
            line(lines[r][0],0,lines[r][1],height);
           }           
       }
  }
  if (keyPressed) {
    if (key == 'a') {
      tipe++;
    }
    if (key == 's') {
      tipe--;
    }
    if(tipe==3){
      tipe=0;
    }
  }
}
