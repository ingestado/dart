import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuenta=0;
boolean calibrated = false;

void setup() {
  size( 640, 480, P3D);
  kinect= new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  
  
}

void draw() {
  background(255);
  kinect.update();
  
  drawHUD();
  }
  
  void drawHUD() {
  
 // image( kinect.depthImage(), 0, 0, 160, 120);
  loadPixels();
//  if ( player != -1 ) {
    int[] userList = kinect.getUsers();
    int[] up = kinect.userMap();
    for (int i = 0; i < up.length; i++) { 
      if (cuenta==10){ //3=vertical, 7= vertical ancho.10= oblicuo, 90=oblicuo ancho, más demasiado separado
        cuenta=0;
      // if the current pixel is on a user
            if (up[i] != 0) {
        // make it green
        pixels[i] = color(0, 255, 0); //The color you want for all pleople
      }
      }
      else{cuenta++;}
    }
 // }
  updatePixels();
}
