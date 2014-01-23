
float s = 0; //Separación entre hojas de cesped
int total = 400;
int xc = 0;
float[][] coordI = new float [400][2];
float[][] coordF = new float [400][2];
float[][] coordP = new float [400][2];
float[] aleatorio = new float [400];

void setup(){
  size(700,500);
  background(0);
  s = width/total;
  
  for(int q=0; q<400; q++){
      coordI[q][0] = xc;
      coordI[q][1] = height;
      coordP[q][0] = coordI[q][0];
      coordP[q][1] = coordI[q][1];
      coordF[q][0] = coordI[q][0] + random(-3,3);
      coordF[q][1] = height-15;
      aleatorio[q] = random(-1,+1); 
      xc = xc + 2;
  }
  
}

void draw(){
  
  for(int q=0; q<400; q++){
      
      fill(255);
      stroke(255);
      line(coordI[q][0],coordI[q][1],coordP[q][0],coordP[q][1]);
     
      if(coordP[q][1] > coordF[q][1]){
        coordP[q][0] = coordP[q][0] + aleatorio[q];
        coordP[q][1]--;
      }
  }
  println("width: " + width);
  println("S: " + s);
  println("[ " + coordI[3][0] +", "+ coordI[3][1] +", "+ coordP[3][0] +", "+ coordP[3][1] +" ]");
  
}
