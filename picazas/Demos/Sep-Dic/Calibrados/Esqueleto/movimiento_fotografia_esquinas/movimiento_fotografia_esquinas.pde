import SimpleOpenNI.*;
SimpleOpenNI  kinect;

int XI = 0;
int YI = 0;
int direccion = 0;
int activarDireccion = 0;
int cuenta = 0;
int cuenta2 = 0;
int array[] = new int[307200];
int[] depthValues = new int[307200];
int[] userMap = new int[307200];
int[] userList = new int[10];
PImage cam1 = createImage(640,480,RGB);
PImage cam2 = createImage(640,480,RGB);
PVector jointPos = new PVector();
PVector jointPos2 = new PVector();
int maxValue;
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

void setup()
{
  size(1000, 600);
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
  kinect.update();  
  background(0);   
  userList = kinect.getUsers();
  
  for(int i=0;i<userList.length;i++)
     {
       int userId = userList [i];
      kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);
      kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,jointPos2);
     }
  
  if(cuenta2==15){
      println("left hand:" + jointPos);
      println("Right hand:" + jointPos2);
      println("AD: " + activarDireccion);
      println("Cuenta: " + cuenta);
     // println("Direccion: " + direccion);
     // println(XI + YI);
      cuenta2=0;} 
   else cuenta2++; 
  
////////////////////////////////////////////////////////////////////////
  
  if (activarDireccion == 0){   //manos arriba
    if(jointPos.x < 0 && jointPos.y >0 && jointPos2.x > 0 && jointPos2.y >0){ 
      activarDireccion = 1;
    }
    cam1=kinect.rgbImage();
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam1, XI, YI);
  }
/////////////////////////////////////////////////////////////////////////////  
  else if (activarDireccion == 1){
    cuenta++;
    if (cuenta==40) { //cada 4 = 1 segundo
      cam2=kinect.rgbImage();
      cam2.loadPixels();
    
      for ( int i=0; i < 307200; i++){
        if(maxValue > depthValues[i]){
        array[i]=cam2.pixels[i];}
      else array[i] = 0; }
      
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
      
      cam2.updatePixels();
      translate(0, (height-kinectHeight*reScale)/2);
      scale(reScale);
      image(cam2, XI, YI);
    }
      
    else if (cuenta==160){
      cuenta=0;
      activarDireccion = 0;
      println("Reinicio");
      XI = 0;
      YI = 0;}
      
    else if (cuenta>80) {
      PImage imagen = createImage(640,480,RGB);
      imagen.loadPixels(); 
      
      for ( int i=0; i < 307200; i++){
         imagen.pixels[i] = array[i];}
               
    imagen.updatePixels();
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(imagen, XI, YI); 
    
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
  } 
  else {
   cam1=kinect.rgbImage();
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam1, XI, YI); 
  }
  }
  
  
  
  
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
