import SimpleOpenNI.*;
SimpleOpenNI kinect;

int kinectWidth = 640;
int kinectHeight = 480;
float reScale;
int clickedDepth,clickPosition;
PVector jointPos = new PVector(0,0,0);
int cuenta2=0;
color c = color(255, 0, 0);
int maxValue=1500;
PVector p= new PVector (0,0); 

void setup(){
  size(1000,650);
  background(0,255,0);
  kinect= new SimpleOpenNI(this);
  reScale = (float) width / kinectWidth;
    
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();
}

void draw(){
  kinect.update();
  
  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array

  PImage cam = createImage(640,480,RGB);
  fill(0,255,0,10);
  rect(0,0,width, height);
  
  cam.loadPixels(); 
    for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        cam.pixels[ clickPosition] = color(255);}
      }
    }
  }
  cam.updatePixels();
  
  for ( int h=0; h<20; h++){
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(-50,width+50),random(-50,0));
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(-50,width+50),random(height,height+50));
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(-50,0),random(-50,height+50));
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(width,width+50),random(-50,height+50));
  }
  
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0); 
}

void keyPressed()
{
  switch(key)
  {
  case ' ':
    kinect.setMirror(!kinect.mirror());
    break;
  case 'q':
    maxValue += 100;
    break;
  case 'a':
    maxValue -= 100;
    break;
  }
}
