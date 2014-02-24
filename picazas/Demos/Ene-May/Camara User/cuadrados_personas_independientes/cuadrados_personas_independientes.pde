
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] lines;                  //{line}{x,y}
int[][] min = new int[6][2];    //{person}{x,y}
int[][] max = new int[6][2];
int before = 0;
int now = 0;
int kinectWidth = 640;
int kinectHeight = 480;
int maxValue = 2500;
float reScale;
int clickedDepth,clickPosition;


void setup(){
  size(700,500);
  background(0);
  reScale = (float) width / kinectWidth;
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);

}

void draw(){
  println("ASDE");
  kinect.update();
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  scale(reScale);
  
  background(0);
  for(int s=0; s<6; s++){
     min[s][0] = width;
     min[s][1] = height;
     max[s][0] = 0;
     max[s][1] = 0;
  }
  
  if (kinect.getNumberOfUsers() > 0) {
   cam.loadPixels();
   for(int z = 0; z < userList.length; z++) {
    for(int h = 0; h < 480; h++){           //See all the pixels
     for(int w = 0; w < 640; w++){
       clickPosition = w + (h*640);        //We see which pixel we are working on
       if (userMap[clickPosition] != 0) {
           cam.pixels[clickPosition] = color(255);
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
    } //For end
    
    stroke(255);
    line(min[z][0],min[z][1],min[z][0],max[z][1]);
    line(min[z][0],min[z][1],max[z][0],min[z][1]);
    line(max[z][0],min[z][1],max[z][0],max[z][1]);
    
    }
    cam.updatePixels();
    translate(0, (height-kinectHeight*reScale)/2);    
    image(cam,0,0);
    
  }    
}

