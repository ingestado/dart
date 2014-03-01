
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int t=0;
int cuenta=0;
PVector jointPos = new PVector();
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

void setup(){
  size (1000,720);
  kinect= new SimpleOpenNI(this);
  background(0);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
}

void draw(){
  kinect.update();
  
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  PImage cam = createImage(640,480,RGB);
  
  fill(0,0,0,35);
  rect(0,0,width,height);
  
  if (kinect.getNumberOfUsers() > 0) { 
    cam.loadPixels(); 
    for(int z = 0; z < userList.length; z++) { 
        for (int i = 0; i < userMap.length; i++) { 
          if (userMap[i] != 0) {
            switch(userList[z]){
              case 0:
                cam.pixels[i] = color(0, 255, 0); //The color you want for all pleople
                break;
              case 1:
                cam.pixels[i] = color(255, 0, 0); //The color you want for all pleople
                break;
              case 2:
                cam.pixels[i] = color(0, 0, 255); //The color you want for all pleople
                break;
              case 3:
                cam.pixels[i] = color(255, 255, 255); //The color you want for all pleople
                break;
              case 4:
                cam.pixels[i] = color(255, 255, 0); //The color you want for all pleople
                break;
              case 5:
                cam.pixels[i] = color(0, 255, 255); //The color you want for all pleople
                break;
              default:
                cam.pixels[i] = color(255, 0, 255); //The color you want for all pleople
                break;            
            }
          }
        }
    }
   // display the changed pixel array
   cam.updatePixels();
   translate(0, (height-kinectHeight*reScale)/2);
   scale(reScale);
   image(cam,0,0); 
  }
  
  
 for(int i=0;i<userList.length;i++)
 {
  kinect.getJointPositionSkeleton(i,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);
}
}

