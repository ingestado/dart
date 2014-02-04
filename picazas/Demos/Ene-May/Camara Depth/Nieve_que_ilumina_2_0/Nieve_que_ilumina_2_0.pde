
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[] nieveSueloX = new int[6]; 
int[] nieveSueloY = new int[6];
int[][] copos = new int[50][2]; //Position (X,Y) of 100 snow balls
int[][] luz = new int[50][2];
int[][] luzSize = new int[50][2];
int[][] on = new int[50][2];    //On1, On2
int[] part = new int[50];
int[] pixelCopo = new int[50];
int[] activados = new int[50];
int dis = 0;
int num = 0;
int cuenta = 0;
int cuentaC = 0;
int altura = 50;
int kinectWidth = 640;
int kinectHeight = 480;
int maxValue = 2500;
float reScale;
int clickedDepth,clickPosition;

void setup(){
  size(700,500);
  background(0);
  reScale = (float) width / kinectWidth;
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  
  nieveSueloX[5] = -100;
  nieveSueloX[0] = 0;
  nieveSueloX[1] = width/6;
  nieveSueloX[2] = width/2;
  nieveSueloX[3] = 2*width/3;
  nieveSueloX[4] = width+100; 
  nieveSueloY[5] = 600;
  nieveSueloY[0] = height-20;
  nieveSueloY[1] = height-2*height/20;
  nieveSueloY[2] = height+20-height/20;
  nieveSueloY[3] = height-height/20;
  nieveSueloY[4] = height-height/15;

  
  for(int x=0; x<50; x++){
      copos[x][0] = int(x*(width/100));
      copos[x][1] = -10;
      activados[x] = 0;
      part[x] = 0;
      on[x][0] = 0;
      on[x][1] = 0;
      luz[x][0] = 0;
      luz[x][1] = 0;
      luzSize[x][0] = 1;
      luzSize[x][1] = 1;
  }
  
}

void draw(){
 // println("ASE");
  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);

  fill(0);
  rect(0,0,width,height);
   
  stroke(255);
  fill(255);
  beginShape();
  curveVertex(nieveSueloX[5], nieveSueloY[5]);
  curveVertex(nieveSueloX[0], nieveSueloY[0]); 
  curveVertex(nieveSueloX[1], nieveSueloY[1]);
  curveVertex(nieveSueloX[2], nieveSueloY[2]);
  curveVertex(nieveSueloX[3], nieveSueloY[3]);
  curveVertex(nieveSueloX[4], nieveSueloY[4]);
  curveVertex(width + 150, height + 100);
  curveVertex(-150,height + 100);
  curveVertex(nieveSueloX[0], nieveSueloY[0]);
  endShape();
  
  if(cuenta == 40){
     dis = int(random(0,49));
     cuentaC++;
     copos[cuentaC][0] = int(dis * (width/100));
     copos[cuentaC][1] = 0;
     cuenta = 0;
  }
  else{
    cuenta++;
  }
  activados[cuentaC] = 1;
  
  if(cuentaC == 49){
    cuentaC = 0;
  }
  
  for(int x=0; x<50; x++){ 
    
    copos[x][1]++;
    
    if(activados[x] == 1 && on[x][0] == 0 && on[x][1] == 0){
      fill(255);
      ellipseMode(CENTER);
      ellipse(copos[x][0],copos[x][1],5,5);
    }
    
    if(copos[x][1] > height){
      activados[x] = 0;
      on[x][0] = 0;
      on[x][1] = 0;
      luz[x][0] = 0;
      luz[x][1] = 0;
      luzSize[x][0] = 1;
      luzSize[x][1] = 1;
      copos[x][0] = x * (width/100);
      copos[x][1] = -10;
    }
    
    
    if(on[x][0] == 0 && on[x][1] == 0){
      pixelCopo[x] = int( (copos[x][0] + (width*copos[x][1])) / reScale);
      cam.loadPixels();
      for(int w = 0; w < 640; w++){           //See all the pixels
       for(int h = 0; h < 480; h++){
         clickPosition = w + (h*640);        //We see which pixel we are working on
         clickedDepth = depthValues[clickPosition];    //See the pixel's value 
         if (clickedDepth > 455){
           if (maxValue > clickedDepth){
             if (pixelCopo[x] == clickPosition){
               activados[x] = 0;
               on[x][0] = 1;
             }
           }
         }
       }
      } 
      cam.updatePixels();
     /* translate(0, (height-kinectHeight*reScale)/2);
      scale(reScale);
      image(cam,0,0);*/
    }
    
     if(on[x][0] == 1 && on[x][1] == 0){
        activados[x] = 0;
        luz[x][0] = copos[x][0];
        luz[x][1] = copos[x][1];  
        on[x][1] = 1;
        part[x] = 1;
        on[x][0] = 0;
        luzSize[x][0] = 1;
        luzSize[x][1] = 1;
      }
      else if(on[x][1] == 1){
        println(luzSize[x][1] + " , " + luzSize[x][0]);
        fill(255);
        ellipseMode(CENTER);
        ellipse(luz[x][0],luz[x][1],luzSize[x][1],luzSize[x][0]);
        if(luzSize[x][0] == 0 && part[x] == 0){
          on[x][1] = 0;
          part[x] = 0;
        }
        else if (luzSize[x][0] < 15 && part[x] == 1){
          luzSize[x][1] ++;
          if(cuenta == 2){
            luzSize[x][0] ++;
          }
        }
        else{
          part[x] = 0;
          luzSize[x][1] --;
          if(cuenta == 2){
            luzSize[x][0] --;
          }
        }
      }
      
      
  }
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
