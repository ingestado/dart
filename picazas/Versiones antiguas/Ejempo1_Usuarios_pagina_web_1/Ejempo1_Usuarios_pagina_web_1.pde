// Kinect Basic Example by Amnon Owed (15/09/12)
 
// import library
import SimpleOpenNI.*;
// declare SimpleOpenNI object
SimpleOpenNI context;
 
// PImage to hold incoming imagery
PImage cam; //We don't use it
 
void setup() {
  // same as Kinect dimensions
  size(640, 480);
  // initialize SimpleOpenNI object
  context = new SimpleOpenNI(this);
  if (context.isInit() == false) {
    // if context.enableScene() returns false
    // then the Kinect is not working correctly
    // make sure the green light is blinking
    println("Kinect not connected!");
    exit();
  } else {
    // mirror the image to be more intuitive
    context.enableDepth();
    context.enableUser();
    context.setMirror(true);
  }
}
 
void draw() {
  // update the SimpleOpenNI object
  context.update();
  // put the image into a PImage
  
  // display the image
  image(context.userImage(), 0, 0);
}
