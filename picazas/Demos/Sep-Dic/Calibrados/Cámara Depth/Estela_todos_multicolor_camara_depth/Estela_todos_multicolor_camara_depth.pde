import SimpleOpenNI.*;

SimpleOpenNI kinect;

int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;
int clickedDepth,clickPosition;
int maxValue;
int a=0;

void setup(){
  size (1280, 720);
  kinect= new SimpleOpenNI(this);
  background(0);
  reScale = (float) width / kinectWidth;
  
  if (kinect.isInit()==false){
   println("Nada de nada chato");
   exit();
   return; 
  }
  
  kinect.setMirror(true);
  kinect.enableDepth();
  
  maxValue = 2500;
  
}


void draw()
{
  // update the cam
  kinect.update();
  fill(0,0,0,35);
  rect(0,0,width,height);

  PImage cam = createImage(640,480,RGB);

  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  cam.loadPixels();

  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        switch (a){
          case 0:
          
            cam.pixels[ clickPosition] = color(0, 255, 0);
            break;
          
          case 1:           
            cam.pixels[ clickPosition] = color(255, 0, 0);
            break;
            
          case 2:           
            cam.pixels[ clickPosition] = color(0, 0, 255);
            break;
            
          case 3:           
            cam.pixels[ clickPosition] = color(255, 255, 0);
            break;
            
          case 4: 
            cam.pixels[ clickPosition] = color(0, 255, 255);
            break;
          
          case 5:           
            cam.pixels[ clickPosition] = color(255, 0, 255);
            break;
                     
          case 6:           
            cam.pixels[ clickPosition] = color(125, 255, 100);
            break;
                     
          case 7:          
            cam.pixels[ clickPosition] = color(50, 255, 0);
            break;
          
          case 8:           
            cam.pixels[ clickPosition] = color(0, 255, 200);
            break;
                     
          case 9:           
            cam.pixels[ clickPosition] = color(95, 255, 22);
            break;
                      
          case 10:           
            cam.pixels[ clickPosition] = color(90, 25, 160);
            a=0;
            break;
            
      }
     }  
    }
   }
  }
  if (a==10) a=0;
  else  a++;
  cam.updatePixels();
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  image(cam,0,0);
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
