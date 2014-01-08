import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
boolean calibrated = false;
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

void setup() {
  size( 1000, 720, P3D);
  background(0);
  reScale = (float) width / kinectWidth;
  kinect= new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
}

void draw() {
  background(255);
  kinect.update();
  
  drawHUD();
  }
  
  void drawHUD() {
  
  PImage cam = createImage(640,480,RGB);
  cam.loadPixels();
//  if ( player != -1 ) {
    int[] userList = kinect.getUsers();
    int[] up = kinect.userMap();
    for (int i = 0; i < up.length; i++) { 
      if (cuenta==7||cuenta==8){ //3=vertical, 7= vertical ancho.10= oblicuo, 90=oblicuo ancho, más demasiado separado
      cuenta++;
            if (up[i] != 0) {
        // make it green
        cam.pixels[i] = color(0, 255, 0); //The color you want for all pleople
      }
      }
      else if(cuenta==9){
        cuenta=0;
      // if the current pixel is on a user
            if (up[i] != 0) {
        // make it green
        cam.pixels[i] = color(0, 255, 0);
            }
      }
      else{cuenta++;
    cam.pixels[i] = color(255, 255, 255);}
      if (up[i] != 1) cam.pixels[i] = color(255, 255, 255);
    }
 // }
  cam.updatePixels();
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);
}
