import SimpleOpenNI.*;
SimpleOpenNI kinect;

int[][] rayo;
int cuenta = 0;
int fin = 0;
int primero = 1;
int par = 1;
int act = 1;
int finif = 0;
int cantidad = 0;
int kinectWidth = 640;
int kinectHeight = 480;
int clickedDepth,clickPosition;
int maxValue;
float reScale;


void setup(){
  size(1000,650,P3D);
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
  
  fill(0);
  rect(-1,-1,width+1,height+1);
  rayo = new int[14][2];
  for (int i = 0; i < 14; i++) {
      for (int j = 0; j < 2; j++) {
          rayo[i][j] = 0;
      }
    }
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
        cam.pixels[ clickPosition] = color(120,0,0);}}
    }
  }
  cam.updatePixels();
  
  //Para separar los rayos en tiempo
  /*if (cuenta == 50){
    cuenta = 0;
    act = 1;
  }
  else { 
    cuenta++;
  }*/
  
    fill(0,0,0,50);
    rect(-1,-1,width+1,height+1);
    
   // if(act==1){
    
  if(fin==0){
    if (primero==1){
      primero = 0; 
      float numero = random(0,width); 
      rayo[0][0] = int(numero);
      rayo[0][1] = -150;
    }
    else {
      if (finif == 0){
      for(int w=1; w<14; w++){
        if (finif == 0){
        if (rayo[w][0] == 0){
          if(par==1){ 
            par = 0;
            float num = random(0,30);
            rayo[w][0] = rayo[w-1][0] + int(num);
            if(rayo[w][0]>width) {rayo[w][0]=width;}
            float num2 = random(40,100);
             rayo[w][1] = rayo[w-1][1] + int(num2); 
            if(w==13) {
              rayo[w][1]=height+50;
              fin = 1;
              act = 0;
            }
           finif = 1;
          }
          else{
            par = 1;
            float num = random(-30,0);
            rayo[w][0] = rayo[w-1][0] + int(num);
            if(rayo[w][0]>width) {rayo[w][0]=2;}
            float num2 = random(40,100);
            rayo[w][1] = rayo[w-1][1] + int(num2);
            if(w==13) {
              rayo[w][1]=height+50;
              fin = 1;
              act = 0;
            } 
            finif = 1;
          }
        } 
      }
      }
      
      for(int w=1; w<14; w++){
        if (rayo[w][0] != 0){
          cantidad++;
          println(cantidad);
        }
      }
      
      switch (cantidad){
        case 1:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          endShape();
          break;
          
        case 2:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          endShape();
          break;
        
        case 3:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          endShape();
          break;
          
        case 4:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          endShape();
          break;
          
        case 5:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          endShape();
          break;
          
        case 6:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          endShape();
          break;
          
        case 7:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          endShape();
          break;
          
        case 8:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          curveVertex(rayo[8][0], rayo[8][1]);
          endShape();
          break;
          
        case 9:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          curveVertex(rayo[8][0], rayo[8][1]);
          curveVertex(rayo[9][0], rayo[9][1]);
          endShape();
          break;
          
        case 10:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          curveVertex(rayo[8][0], rayo[8][1]);
          curveVertex(rayo[9][0], rayo[9][1]);
          curveVertex(rayo[10][0], rayo[10][1]);
          endShape();
          break;
          
        case 11:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          curveVertex(rayo[8][0], rayo[8][1]);
          curveVertex(rayo[9][0], rayo[9][1]);
          curveVertex(rayo[10][0], rayo[10][1]);
          curveVertex(rayo[11][0], rayo[11][1]);
          endShape();
          break;
          
        case 12:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          curveVertex(rayo[8][0], rayo[8][1]);
          curveVertex(rayo[9][0], rayo[9][1]);
          curveVertex(rayo[10][0], rayo[10][1]);
          curveVertex(rayo[11][0], rayo[11][1]);
          curveVertex(rayo[12][0], rayo[12][1]);
          endShape();
          break;
          
        case 13:
        
          stroke(255);
          noFill();
          beginShape();
          curveVertex(rayo[0][0], rayo[0][1]); 
          curveVertex(rayo[1][0], rayo[1][1]); 
          curveVertex(rayo[2][0], rayo[2][1]);
          curveVertex(rayo[3][0], rayo[3][1]);
          curveVertex(rayo[4][0], rayo[4][1]);
          curveVertex(rayo[5][0], rayo[5][1]);
          curveVertex(rayo[6][0], rayo[6][1]);
          curveVertex(rayo[7][0], rayo[7][1]);
          curveVertex(rayo[8][0], rayo[8][1]);
          curveVertex(rayo[9][0], rayo[9][1]);
          curveVertex(rayo[10][0], rayo[10][1]);
          curveVertex(rayo[11][0], rayo[11][1]);
          curveVertex(rayo[12][0], rayo[12][1]);
          curveVertex(rayo[13][0], rayo[13][1]);
          endShape();
          break;

      }
      if(cantidad==12){
        fill(255);
        rect(0,0,width,height);
      }
      else{
        translate(0, (height-kinectHeight*reScale)/2);
        scale(reScale);
        image(cam,0,0);
      }
      cantidad=0;
    }
    }    
   }
  else {
    fin = 0;
    primero = 1;

    for (int i = 0; i < 14; i++) {
      for (int j = 0; j < 2; j++) {
          rayo[i][j] = 0;
      }
    }
  }
 
finif = 0;
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
