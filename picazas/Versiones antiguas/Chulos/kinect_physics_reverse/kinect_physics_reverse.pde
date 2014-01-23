// Kinect Physics Example by Amnon Owed (15/09/12)
//shapes go up- Anthony Rhys, 24/09.12 and gravity set a little slower. 



// import libraries

import processing.opengl.*; // opengl

import SimpleOpenNI.*; // kinect

import blobDetection.*; // blobs

import toxi.geom.*; // toxiclibs shapes and vectors

import toxi.processing.*; // toxiclibs display

import pbox2d.*; // shiffman's jbox2d helper library

import org.jbox2d.collision.shapes.*; // jbox2d

import org.jbox2d.common.*; // jbox2d

import org.jbox2d.dynamics.*; // jbox2d



// declare SimpleOpenNI object

SimpleOpenNI context;

// declare BlobDetection object

BlobDetection theBlobDetection;

// ToxiclibsSupport for displaying polygons

ToxiclibsSupport gfx;

// declare custom PolygonBlob object (see class for more info)

PolygonBlob poly;



// PImage to hold incoming imagery and smaller one for blob detection

PImage cam, blobs;

// the kinect's dimensions to be used later on for calculations

int kinectWidth = 640;

int kinectHeight = 480;

// to center and rescale from 640x480 to higher custom resolutions

float reScale;



// background and blob color

color bgColor, blobColor;

// three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)

String[] palettes = {

  "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634", 

  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031", 

  "-1978728,-724510,-15131349,-13932461,-4741770,-9232823,-3195858,-8989771,-2850983,-10314372"

};

color[] colorPalette;



// the main PBox2D object in which all the physics-based stuff is happening

PBox2D box2d;

// list to hold all the custom shapes (circles, polygons)

ArrayList<CustomShape> polygons = new ArrayList<CustomShape>();



void setup() {

  // it's possible to customize this, for example 1920x1080

  size(1280, 720, OPENGL);

  context = new SimpleOpenNI(this);

  // initialize SimpleOpenNI object

  if (context.isInit()==false)  { 

    // if context.enableScene() returns false

    // then the Kinect is not working correctly

    // make sure the green light is blinking

    println("Kinect not connected!"); 

    exit();

  } else {

    // mirror the image to be more intuitive

    context.setMirror(true);

    // calculate the reScale value

    // currently it's rescaled to fill the complete width (cuts of top-bottom)

    // it's also possible to fill the complete height (leaves empty sides)

    reScale = (float) width / kinectWidth;

    // create a smaller blob image for speed and efficiency

    blobs = createImage(kinectWidth/3, kinectHeight/3, RGB);

    // initialize blob detection object to the blob image dimensions

    theBlobDetection = new BlobDetection(blobs.width, blobs.height);

    theBlobDetection.setThreshold(0.2);

    // initialize ToxiclibsSupport object

    gfx = new ToxiclibsSupport(this);

    // setup box2d, create world, set gravity

    box2d = new PBox2D(this);

    box2d.createWorld();
// second number here is gravity speed 30 faster than 10
    box2d.setGravity(0, 15);

    // set random colors (background, blob)

    setRandomColors(1);

  }

}



void draw() {

  background(bgColor);

  // update the SimpleOpenNI object

  context.update();

  // put the image into a PImage

  cam = context.userImage();

  // copy the image into the smaller blob image

  blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);

  // blur the blob image

  blobs.filter(BLUR, 1);

  // detect the blobs

  theBlobDetection.computeBlobs(blobs.pixels);

  // initialize a new polygon

  poly = new PolygonBlob();

  // create the polygon from the blobs (custom functionality, see class)

  poly.createPolygon();

  // create the box2d body from the polygon

  poly.createBody();

  // update and draw everything (see method)

  updateAndDrawBox2D();

  // destroy the person's body (important!)

  poly.destroyBody();

  // set the colors randomly every 240th frame

  setRandomColors(240);

}



void updateAndDrawBox2D() {

  // if frameRate is sufficient, add a polygon and a circle with a random radius

  if (frameRate > 29) {

    polygons.add(new CustomShape(kinectWidth/2, 400, -1));

    polygons.add(new CustomShape(kinectWidth/2, 400, random(2.5, 20)));

  }

  // take one step in the box2d physics world

  box2d.step();



  // center and reScale from Kinect to custom dimensions

  translate(0, (height-kinectHeight*reScale)/2);

  scale(reScale);



  // display the person's polygon  

  noStroke();

  fill(blobColor);

  gfx.polygon2D(poly);



  // display all the shapes (circles, polygons)

  // go backwards to allow removal of shapes

  for (int i=polygons.size()-1; i>=0; i--) {

    CustomShape cs = polygons.get(i);

    // if the shape is off-screen remove it (see class for more info)

    if (cs.done()) {

      polygons.remove(i);

    // otherwise update (keep shape outside person) and display (circle or polygon)

    } else {

      cs.update();

      cs.display();

    }

  }

}



// sets the colors every nth frame

void setRandomColors(int nthFrame) {

  if (frameCount % nthFrame == 0) {

    // turn a palette into a series of strings

    String[] paletteStrings = split(palettes[int(random(palettes.length))], ",");

    // turn strings into colors

    colorPalette = new color[paletteStrings.length];

    for (int i=0; i<paletteStrings.length; i++) {

      colorPalette[i] = int(paletteStrings[i]);

    }

    // set background color to first color from palette

    bgColor = 255;
    //colorPalette[0];

    // set blob color to second color from palette

    blobColor = 180;

    // set all shape colors randomly

    for (CustomShape cs: polygons) { cs.col = getRandomColor(); }

  }

}



// returns a random color from the palette (excluding first aka background color)

color getRandomColor() {

  return colorPalette[int(random(1, colorPalette.length))];

}
