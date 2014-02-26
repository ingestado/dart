
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] pos = new int [14][2];    //{x,y}
int[][] min = new int[6][2];    //{person}{x,y}
int[][] max = new int[6][2];
PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
PImage square;
int before = 0;
int now = 0;
int clickedDepth,clickPosition;
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
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  int[] depthValues = kinect.depthMap();
  scale(reScale);
  
  fill(0);
  rect(0,0,width,height);
  for(int s=0; s<6; s++){
     min[s][0] = width;
     min[s][1] = height;
     max[s][0] = 0;
     max[s][1] = 0;
  }
  
  if (kinect.getNumberOfUsers() > 0) {   
    for (int z=0; z<userList.length; z++){  
      for(int h = 0; h < 480; h++){           //See all the pixels
       for(int w = 0; w < 640; w++){
         clickPosition = w + (h*640);        //We see which pixel we are working on
         if (userMap[clickPosition] != 0) {

             if(w < min[z][0]){
               min[z][0] = w;
             }
             if(w > max[z][0]){
               max[z][0] = w;
             }
             if(h < min[z][1]){
               min[z][1] = h;
             }
             if(h > max[z][1]+5){
               max[z][1] = h;
             } 
           }
         }
      }
      
      for( int u=0; u<14; u++){
        int minS = int( u * width/14);
        int maxS =int( (u+1) * width/14);
        
           if(min[z][0]<maxS && min[z][0]>minS && max[z][0]>maxS){
             if(pos[u][1]>-1){
               pos[u][1]--;
             }
           }
           else if(min[z][0]<minS && max[z][0]>maxS){
             if(pos[u][1]>-1){
               pos[u][1]--;
             }
           }
           else if(min[z][0]<minS && max[z][0]>minS && max[z][0]<maxS){
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
