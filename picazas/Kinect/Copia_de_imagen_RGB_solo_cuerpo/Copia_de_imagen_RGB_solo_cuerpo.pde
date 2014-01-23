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
SimpleOpenNI  kinect;

PVector jointPos = new PVector();
PVector jointPos2 = new PVector();
int cuenta=0;
int cuenta2=0;
int XI = 0;
int YI = 0;
int direccion = 0;
int activarDireccion = 0;
int array[] = new int[307200];
int[] depthValues = new int[307200];
int[] userMap = new int[307200];
int[] userList = new int[10];
PImage cam = createImage(640,480,RGB);
PImage camDepth = createImage(640,480,RGB);
int maxValue;
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

void setup()
{
  size(1000, 720);
  kinect = new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit() == false)
  {
    println("Nada de nada chato"); 
    exit();
    return;
  }

  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();
  maxValue = 2500;
}

void draw()
{
  // update the cam
  kinect.update();
  
  background(0);
   
  userList = kinect.getUsers();
 for(int i=0;i<userList.length;i++)
 {
   int userId = userList [i];
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,jointPos2);
 }
 
 if(cuenta2==60){
  println("left hand:" + jointPos);
  println("Right hand:" + jointPos2);
  println("AD: " + activarDireccion);
  println("Direccion: " + direccion);
  println(XI + YI);
  cuenta2=0;
  } else cuenta2++; 
  
  if (cuenta==50) {
    XI = 0;
    YI = 0;
    depthValues = kinect.depthMap();
    userMap = kinect.userMap(); 
    cam=kinect.rgbImage();
    cam.loadPixels();
    
    for ( int i=0; i < 307200; i++){
      if(maxValue > depthValues[i]){
      array[i]=cam.pixels[i];}
    else array[i] = 0; }
      
    cam.updatePixels();}
    
  if (cuenta>100) {
  PImage imagen = createImage(640,480,RGB);
  imagen.loadPixels();
  
  
  for ( int i=0; i < 307200; i++){
     imagen.pixels[i] = array[i];}
     
  if(jointPos.x < 0 && jointPos.y >0 && jointPos2.x > 0 && jointPos2.y >0){
    activarDireccion = 1;}
     
  if (activarDireccion == 1){
  if(jointPos.x > 0 && jointPos.y >0){            //Arriba derecha
   direccion = 1;
   }
  else if (jointPos.x < 0 && jointPos.y >0){      //Arriba izquierda
   direccion = 2;
   }
  else if (jointPos.x > 0 && jointPos.y <0){      //Debajo derecha
   direccion = 3;
   }
  else if (jointPos.x < 0 && jointPos.y <0){      //Debajo izquierda
   direccion = 4;
   } 
  }
  imagen.updatePixels();
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(imagen, XI, YI);
  }
  
  switch (direccion) {
    
    case 1:
      XI += 5;
      YI -= 5;
      break;
    case 2:
      XI -= 5;
      YI -= 5;
      break;
    case 3:
      XI += 5;
      YI += 5;
      break;
    case 4:
      XI -= 5;
      YI += 5;
      break;
    
  }
  
  cuenta++;
  if (cuenta==200) {cuenta = 0;
  println("Reinicio");
  XI = 0;
  YI = 0;}
  
}

void keyPressed(){
  switch(key)
  {
  case 'q':
    maxValue+=100;
    break;
  case 'a':
    maxValue-=100;
    break;
  }  
}  

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

