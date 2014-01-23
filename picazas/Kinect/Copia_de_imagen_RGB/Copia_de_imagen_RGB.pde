/* --------------------------------------------------------------------------
 * SimpleOpenNI DepthImage Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;


SimpleOpenNI  context;

int cuenta=0;
int array[] = new int[307200];
PImage cam;

void setup()
{
  size(640*2, 480);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // mirror is by default enabled
  context.setMirror(true);

  // enable ir generation
  context.enableRGB();
}

void draw()
{
  // update the cam
  context.update();

  background(200, 0, 0);
  if (cuenta<100)cuenta ++;
  println(cuenta);
  // draw depthImageMap
  
  if (cuenta==50) {
    cam=context.rgbImage();
    cam.loadPixels();
    
    for ( int i=0; i < 307200; i++){
      array[i]=cam.pixels[i];}
      
    cam.updatePixels();}
    
  if (cuenta==100) {
  PImage imagen = createImage(640,480,RGB);
  imagen.loadPixels();
  
  for ( int i=0; i < 307200; i++){
     imagen.pixels[i] = array[i];}
     
  imagen.updatePixels();
  image(imagen, 0, 0);}

  // draw irImageMap
  image(context.rgbImage(), 640, 0);
}

