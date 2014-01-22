
int[] nieveSueloX = new int[6]; 
int[] nieveSueloY = new int[6];
int[][] copos = new int[700][2];
int[] activados = new int[700];
int dis = 0;
int num = 0;
int cuenta = 0;
int altura = 50;

void setup(){
  size(700,500);
  background(0);
  
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

  
  for(int x=0; x<width; x++){
      copos[x][0] = x;
      copos[x][1] = -10;
      activados[x] = 0;
  }
}

void draw(){

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
  
  if(cuenta == 2){
     dis = int(random(0,width));
     cuenta = 0;
  }
  else{
    cuenta++;
  }
  activados[dis] = 1;
  for(int x=0; x<width; x++){       
    if(activados[x] == 1){
      fill(255);
      ellipseMode(CENTER);
      ellipse(copos[x][0],copos[x][1],5,5);
      copos[x][1]++;
    }
    
    if(copos[x][1] > height){
      activados[dis] = 0;
      copos[x][0] = x;
      copos[x][1] = -10;
    }
  }
}
