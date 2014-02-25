
import SimpleOpenNI.*;
SimpleOpenNI kinect;


int[][] lines;                  //{line}{y0,y1}
int[] actLines;
int[][] min = new int[6][2];    //{person}{x,y}
int[][] max = new int[6][2];
int c;
int nLines = 150;
PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
int kinectWidth = 640;
int kinectHeight = 480;
int tipe = 0;
float reScale;

void setup(){
  size (900,600,P2D);
  background(0);
  c = width/nLines;
  lines = new int[nLines][2];
  actLines =new int [nLines];
  for(int r=0; r<nLines; r++){
    lines[r][0] = int(random( (c*r)-25, (c*r)+25 ));
    lines[r][1] = int(random( (c*r)-25, (c*r)+25 ));
    actLines[r] = 0;
  }
  
  reScale = (float) width / kinectWidth;
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  background(0);
  kinect.update();
  int[] userList = kinect.getUsers();
  int[] userMap = kinect.userMap();
  PImage cam = createImage(640,480,RGB);
  
  for(int s=0; s<6; s++){
     min[s][0] = width;
     min[s][1] = height;
     max[s][0] = 0;
     max[s][1] = 0;
  }
      
   if (kinect.getNumberOfUsers() > 0) {
       cam.loadPixels(); 
       for(int z = 0; z < userList.length; z++) {    
         for(int x = 0; x < 640; x++){           //See all the pixels
           for(int y = 0; y < 480; y++){         
               int clickPosition = x + (y*640); 
               if (userMap[clickPosition] != 0) {
                 cam.pixels[clickPosition] = color(255);
                 if(x < min[z][0]){
                   min[z][0] = x;
                 }
                 if(x > max[z][0]){
                   max[z][0] = x;
                 }
                 if(y < min[z][1]){
                   min[z][1] = y;
                 }
                 if(y > max[z][1]){
                   max[z][1] = y;
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
        for(int z = 0; z < userList.length; z++) {
          drawLine(lines[w][0],lines[w][1],min[z][0],min[z][1],max[z][0],w);
        }
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
   if (mousePressed == true) {
    println(mouseX+" ; "+mouseY);
  }
  
  for(int r=0; r<nLines; r++){
     if(actLines[r] ==0){ 
        line(lines[r][0],0,lines[r][1],height);
     }
  }
  
  for(int r=0; r<nLines; r++){
    actLines[r] = 0;
  }
}

void drawLine(int l0, int l1,int minx, int miny, int maxx,int w){
  int s = l1 - l0 - ((l1-l0)/2);
  if(l1<maxx && l1>minx){
     if(l1>(minx+(maxx-minx)/2)){
       stroke(255);
       line(l0,0,l1,miny-50);
       /*line(lines[w][1], (min.y-50), (max.x+5+s), (min.y+100));
       line((max.x+5+s),  (min.y+100), (max.x+30+s), (min.y+200));
       line((max.x+30+s), (min.y+200), (max.x+30+s), (height-150));
       line((max.x+30+s), (height-150), (max.x+s), (height+40));*/
       noFill();
       beginShape();
       curveVertex(l1,(miny)); 
       curveVertex(l1,(miny-51)); 
       curveVertex((maxx+5+s),(miny+100)); 
       curveVertex((maxx+30+s),(miny+200));    
       curveVertex((maxx+30+s),(height-150)); 
       curveVertex((maxx+s),(height+40)); 
       curveVertex((maxx),(height+200));
       endShape();
       actLines[w]=1;
     }
     else if(l1<(minx+(maxx-minx)/2)){
       stroke(255);
       line(l0,0,l1,miny-50);
      /* line(lines[w][1],(min.y-50),(min.x-5-s),(min.y+100));
       line((min.x-5-s),(min.y+100),(min.x-30-s),(min.y+200));
       line((min.x-30-s),(min.y+200),(min.x-30-s),(height-150));
       line((min.x-30-s),(height-150),(min.x-s),(height+40));*/
       noFill();
       beginShape();
       curveVertex(l1,(miny));
       curveVertex(l1,(miny-51)); 
       curveVertex((minx-5-s),(miny+100)); 
       curveVertex((minx-30-s),(miny+200)); 
       curveVertex((minx-30-s),(height-150)); 
       curveVertex((minx-s),(height+40)); 
       curveVertex((minx),(height+200));
       endShape();
       actLines[w]=1;
     }
   } 
   
}

