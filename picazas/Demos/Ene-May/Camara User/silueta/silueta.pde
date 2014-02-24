
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] shape;

int before = 0;
int now = 0;
int kinectWidth = 640;
int kinectHeight = 480;
int maxValue = 2500;
float reScale;
int clickedDepth,clickPosition;
int f=0;

void setup(){
  size(700,500);
  background(0);
  reScale = (float) width / kinectWidth;
  int cant = width*height;
  shape = new int [cant][3];  //{x,y,in/out}
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  for(int r=0; r<cant; r++){
    shape[r][0] = 0;
    shape[r][1] = 0;
    shape[r][2] = 0;
  }
}

void draw(){
  println("ASDE"+f);
  f++;
  kinect.update();
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  
  fill(0);
  rect(0,0,width,height);
  
  cam.loadPixels();
    for(int h = 0; h < 480; h++){           //See all the pixels
     for(int w = 0; w < 640; w++){
       clickPosition = w + (h*640);        //We see which pixel we are working on
       clickedDepth = depthValues[clickPosition];    //See the pixel's value 

         if (userMap[clickPosition] != 0){
           now = 1;
         }
         else now = 0;

       if(before < now){
         shape[clickPosition][0] = w-1;
         shape[clickPosition][1] = h;
         shape[clickPosition][2] = 1;
       }
       else if(before > now){
         shape[clickPosition][0] = w;
         shape[clickPosition][1] = h;
         shape[clickPosition][2] = 1;
       }
       before = now;
     }
    } //For end

    cam.updatePixels();

    
  /*  for(int r=0; r<width*height; r++){
      if(shape[r][2] == 1){
        int act = 0;
        int o = (r-(7*width));
        int p = (r+(7*width));
        for (int n=0; n<width*height; n++){
          for(int k=5; k>0; k--){
          if(act == 0 && shape[n][2] == 1 &&  shape[n][1] == shape[r][1]+k){
              if(shape[n][0] < shape[r][0]+10 && shape[n][0] > shape[r][0]-10){
                shape[r+k-4][2] = 0;
                shape[r+k-3][2] = 0;
                shape[r+k-2][2] = 0;
                shape[r+k-1][2] = 0;
                stroke(255);
                line(shape[r][0], shape[r][1],shape[n][0], shape[n][1]); 
                act=1;
              }
          }
          }
        }
      }
    }
   
    for(int r=0; r<width*height; r++){
    shape[r][0] = 0;
    shape[r][1] = 0;
    shape[r][2] = 0;
  }*/
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
  println("maxValue: " + maxValue);
}

