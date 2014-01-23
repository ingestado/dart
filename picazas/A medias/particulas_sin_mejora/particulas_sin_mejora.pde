import SimpleOpenNI.*;       //Kinect
import blobDetection.*;      //Blobs
import processing.opengl.*;  //OpenGL
import java.awt.Polygon;     // this is a regular java import so we can use and extend the polygon class (see PolygonBlob)
import java.util.Collections;
import java.awt.Frame;
import java.awt.BorderLayout;

SimpleOpenNI kinect;            // declare SimpleOpenNI object
BlobDetection theBlobDetection; // declare BlobDetection object
PolygonBlob poly = new PolygonBlob(); // declare custom PolygonBlob object

PImage cam, blobs;    // PImage to hold incoming imagery and smaller one for blob detection
int cuenta=0;
PVector jointPos = new PVector();
// the kinect's dimensions to be used later on for calculations
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

// background color
color bgColor;
// three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)
String[] palettes = {
  "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634", 
  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031", 
  "-16711663,-13888933,-9029017,-5213092,-1787063,-11375744,-2167516,-15713402,-5389468,-2064585"
};
 
// an array called flow of 2250 Particle objects (see Particle class)
Particle[] flow = new Particle[2250];
// global variables to influence the movement of all particles
float globalX, globalY;

void setup(){
  
  size (1280,960,OPENGL);
  kinect= new SimpleOpenNI(this);
  background(0);
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableUser();
  reScale = (float) width / kinectWidth;
  // create a smaller blob image for speed and efficiency
  blobs = createImage(kinectWidth/3, kinectHeight/3, RGB);
  // initialize blob detection object to the blob image dimensions
  theBlobDetection = new BlobDetection(blobs.width, blobs.height);
  theBlobDetection.setThreshold(0.2);
  setupFlowfield();
  
}

void draw(){
  
  kinect.update();
  fill(0);
  rect(0,0,width,height);
  cam = kinect.userImage();
  
  // copy the image into the smaller blob image
  blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);
  // blur the blob image
  blobs.filter(BLUR);
  // detect the blobs
  theBlobDetection.computeBlobs(blobs.pixels);
  
  // clear the polygon (original functionality)
  poly.reset();
  // create the polygon from the blobs (custom functionality, see class)
  poly.createPolygon();
  drawFlowfield();
  
}

void setupFlowfield() {
  
  strokeWeight(2.5);                    // set stroke weight (for particle display) to 2.5
  for(int i=0; i<flow.length; i++) {    // initialize all particles in the flow
    flow[i] = new Particle(i/10000.0);
  }
  setRandomColors(1);                   // set all colors randomly now
  
}

void setRandomColors(int nthFrame) {
  
  if (frameCount % nthFrame == 0) {
    // turn a palette into a series of strings
    String[] paletteStrings = split(palettes[int(random(palettes.length))], ",");
    // turn strings into colors
    color[] colorPalette = new color[paletteStrings.length];
    for (int i=0; i<paletteStrings.length; i++) {
      colorPalette[i] = int(paletteStrings[i]);
    }
    // set background color to first color from palette
    bgColor = colorPalette[0];
    // set all particle colors randomly to color from palette (excluding first aka background color)
    for (int i=0; i<flow.length; i++) {
      flow[i].col = colorPalette[int(random(1, colorPalette.length))];
    }
  }
  
}

void drawFlowfield() {
  
  // center and reScale from Kinect to custom dimensions
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  // set global variables that influence the particle flow's movement
  globalX = noise(frameCount * 0.01) * width/2 + width/4;
  globalY = noise(frameCount * 0.005 + 5) * height;
  // update and display all particles in the flow
  for (Particle p : flow) {
    p.updateAndDisplay();
  }
  // set the colors randomly every 240th frame
  setRandomColors(240);
  
}

