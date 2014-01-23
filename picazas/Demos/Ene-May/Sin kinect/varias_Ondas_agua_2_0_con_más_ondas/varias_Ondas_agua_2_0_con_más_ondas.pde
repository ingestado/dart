
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] p = new int[8][2];
int[][] p2 = new int[8][2];
int[][] p3 = new int[8][2];
int[] inicioCirculo = {1,1,1,1,1,1,1,1};
int[] R = new int[8];
int[] R2 = new int[8];
int[] R3 = new int[8];
int[] c2 = new int[8];
int[] c3 = new int[8];
int tiempo = 0;
int[] contador = new int[8];
int[] contadorTope = {90,90,90,90,90,90,90,90};
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;

void setup(){
  
  size(700,500);
  background(0);
  kinect= new SimpleOpenNI(this);
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

void draw(){  
  
  kinect.update();
  int[] depthValues = kinect.depthMap();
  PImage cam = createImage(640,480,RGB);
  
  cam.loadPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        cam.pixels[ clickPosition] = color(255);}}
    }
  }
  cam.updatePixels();
  
  println("Tiempo: " + tiempo);
  
  if (tiempo<30 && tiempo>0){
    if (inicioCirculo[0] == 1){
      p[0][0] = int(random(0,width));
      p[0][1] = int(random(0,height));
      p2[0][0] = p[0][0];
      p2[0][1] = p[0][1];
      p3[0][0] = p[0][0];
      p3[0][1] = p[0][1];
      R[0] = int(random(0,15));
      R2[0] = R[0];
      R3[0] = R[0];
      contadorTope[0] = int(random(60,120));
      inicioCirculo[0] = 0;
    }
    if (inicioCirculo[0] == 1){
      p[4][0] = int(random(0,width));
      p[4][1] = int(random(0,height));
      p2[4][0] = p[4][0];
      p2[4][1] = p[4][1];
      p3[4][0] = p[4][0];
      p3[4][1] = p[4][1];
      R[4] = int(random(0,15));
      R2[4] = R[4];
      R3[4] = R[4];
      contadorTope[4] = int(random(60,120));
      inicioCirculo[4] = 0;
    }
  }
  
  else if (tiempo>29 && tiempo<60){
    if (inicioCirculo[1] == 1){
      p[1][0] = int(random(0,width));
      p[1][1] = int(random(0,height));
      p2[1][0] = p[1][0];
      p2[1][1] = p[1][1];
      p3[1][0] = p[1][0];
      p3[1][1] = p[1][1];
      R[1] = int(random(0,15));
      R2[1] = R[1];
      R3[1] = R[1];
      contadorTope[1] = int(random(60,120));
      inicioCirculo[1] = 0;
    }
    if (inicioCirculo[0] == 1){
      p[5][0] = int(random(0,width));
      p[5][1] = int(random(0,height));
      p2[5][0] = p[5][0];
      p2[5][1] = p[5][1];
      p3[5][0] = p[5][0];
      p3[5][1] = p[5][1];
      R[5] = int(random(0,15));
      R2[5] = R[5];
      R3[5] = R[5];
      contadorTope[5] = int(random(60,120));
      inicioCirculo[5] = 0;
    }
  }
  
   else if (tiempo>59 && tiempo<90){
    if (inicioCirculo[2] == 1){
      p[2][0] = int(random(0,width));
      p[2][1] = int(random(0,height));
      p2[2][0] = p[2][0];
      p2[2][1] = p[2][1];
      p3[2][0] = p[2][0];
      p3[2][1] = p[2][1];
      R[2] = int(random(0,15));
      R2[2] = R[2];
      R3[2] = R[2];
      contadorTope[2] = int(random(60,120));
      inicioCirculo[2] = 0;
    }
    if (inicioCirculo[0] == 1){
      p[6][0] = int(random(0,width));
      p[6][1] = int(random(0,height));
      p2[6][0] = p[6][0];
      p2[6][1] = p[6][1];
      p3[6][0] = p[6][0];
      p3[6][1] = p[6][1];
      R[6] = int(random(0,15));
      R2[6] = R[6];
      R3[6] = R[6];
      contadorTope[6] = int(random(60,120));
      inicioCirculo[6] = 0;
    }
  }
  
   else if (tiempo>89 && tiempo<120){
    if (inicioCirculo[3] == 1){
      p[3][0] = int(random(0,width));
      p[3][1] = int(random(0,height));
      p2[3][0] = p[3][0];
      p2[3][1] = p[3][1];
      p3[3][0] = p[3][0];
      p3[3][1] = p[3][1];
      R[3] = int(random(0,15));
      R2[3] = R[3];
      R3[3] = R[3];
      contadorTope[3] = int(random(60,120));
      inicioCirculo[3] = 0;
    }
    if (inicioCirculo[0] == 1){
      p[7][0] = int(random(0,width));
      p[7][1] = int(random(0,height));
      p2[7][0] = p[7][0];
      p2[7][1] = p[7][1];
      p3[7][0] = p[7][0];
      p3[7][1] = p[7][1];
      R[7] = int(random(0,15));
      R2[7] = R[7];
      R3[7] = R[7];
      contadorTope[7] = int(random(60,120));
      inicioCirculo[7] = 0;
    }
  }
  else {tiempo = 0;}
  
/////////////////////////////////////////////////////////////////////
//Circulo 1
  
   for (int w = 0; w < 8; w++){
     if(inicioCirculo[w] == 0){
      stroke(255);
      ellipse(p[w][0],p[w][1],R[w],R[w]);
      if(c2[w]>4){
        ellipse(p2[w][0],p2[w][1],R2[w],R2[w]);
      }
      if(c3[w]>8){
        ellipse(p3[w][0],p3[w][1],R3[w],R3[w]);
      }
      R[w]++;
      if(c2[w]>8){
        R2[0]++;
      }
      if(c3[w]>16){
        R3[w]++;
      }
      c2[w]++;
      c3[w]++;
      contador[w]++;
      
      if (contador[w] == contadorTope[w]){
      inicioCirculo[w] = 1;
      contador[w] = 0;
      c2[w] = 0;
      c3[w] = 0;
      R[w] = 0;
      R2[w] = 0;
      R3[w] = 0;
      }
     }
   }
      
   for (int w = 0; w < 8; w++){
     if (R[w]>120){
      R[w] = 0;
      R2[w] = 0;
      R3[w] = 0;
      inicioCirculo[w] = 1;
     }
   }   
      
  tiempo++;
  fill(0,0,0,50);
  rect(0,0,width,height);
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
