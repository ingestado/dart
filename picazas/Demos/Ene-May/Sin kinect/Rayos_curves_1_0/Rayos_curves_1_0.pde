
int[][] rayo;
int fin = 0;
int primero = 1;
int par = 1;
int cuenta = 0;
int cuenta2 = 0;
int cuenta3 = 0;
int act = 1;
int finif = 0;
int cantidad = 0;

void setup(){
  size(1000,650);
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
  
  if (cuenta2 == 50){
    cuenta2 = 0;
    act = 1;
  }
  else { 
    cuenta2++;
    if(cuenta3 == 3){
    cuenta3=0;
    fill(0,0,0,50);
    rect(-1,-1,width+1,height+1);
    }
  }
  
  if (cuenta>3 && act==1){
    
    cuenta=0;
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
  }
cuenta3++;
cuenta++; 
finif = 0;
}
