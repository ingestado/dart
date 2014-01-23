
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int comienzo = 0;
int radio;
int cuentaPixels = 0;
int Pixels = 0;
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;

void setup(){
  size(1000,650);
  background(0);
  kinect= new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
  Pixels = height*width;
  radio = int(width*1.6);
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();  
  maxValue = 2400;
}

void draw(){
  
  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  cuentaPixels = 0;
  
  cam.loadPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        cuentaPixels++;
        cam.pixels[ clickPosition] = color(0);}}
    }
  }
  cam.updatePixels();
  
  if (cuentaPixels < 35000)  {
    comienzo = 1;
  }
  if (comienzo == 1){
    radio-=5;
    if(radio < 30){
      comienzo = 0;
      radio = int(width*1.6);
    }
  }
  
  println("Comienzo: " + comienzo);
  println("Pixels: " + cuentaPixels);
  fill(0);
  rect(0,0,width,height);
  fill(255);
  ellipse(width/2,height-height/20,radio,radio);  
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);

}

void keyPressed(){
  
  println("MaxValue: " + maxValue);
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
