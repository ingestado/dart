
int[][] rayo;
int fin = 0;
int primero = 1;
int par = 1;
int cuenta = 0;
int finif = 0;

void setup(){
  size(500,650);
  background(255);
  rayo = new int[13][2];
  for (int i = 0; i < 13; i++) {
      for (int j = 0; j < 2; j++) {
          rayo[i][j] = 0;
      }
    }
}

void draw(){
  if (cuenta==3){
    for (int i = 0; i < 13; i++) {
      for (int j = 0; j < 2; j++) {
          print(rayo[i][j] + " , ");
        }
    }
    cuenta=0;
  if(fin==0){
    if (primero==1){
      primero = 0; 
      float numero = random(0,500); 
      println("float numero: " + numero); 
      rayo[0][0] = int(numero);
      rayo[0][1] = 0;
    }
    else {
      if (finif == 0){
      for(int w=0; w<13; w++){
        if (finif == 0){
        if (rayo[w][0] == 0){
          if(par==1){ 
            par = 0;
            float num = random(0,30);
            println("float num: " + num);
            rayo[w][0] = rayo[w-1][0] + int(num);
            if(rayo[w][0]>width) {rayo[w][0]=width;}
            float num2 = random(40,100);
            println("float num2: " + num2);
            rayo[w][1] = rayo[w-1][1] + int(num2); 
            if(rayo[w][1]>height) {rayo[w][1]=height;
                fin = 1;}
           finif = 1;
          }
          else{
            par = 1;
            float num = random(-30,0);
            println("floaaaat num: " + num);
            rayo[w][0] = rayo[w-1][0] + int(num);
            if(rayo[w][0]>width) {rayo[w][0]=2;}
            float num2 = random(40,100);
            println("floaaaat num2: " + num2);
            rayo[w][1] = rayo[w-1][1] + int(num2);
            if(rayo[w][1]>height) {rayo[w][1]=height;
                fin = 1;} 
             finif = 1;
          }
        } 
      }
      }
      
      for(int w=1; w<13; w++){
        if (rayo[w][0] != 0){
          stroke(0, 0, 255);
          fill(0);
          line(rayo[w-1][0],rayo[w-1][1],rayo[w][0],rayo[w][1]);
          println("parapachun pachun pin pum");
        }
      }
      
    }
    }    
   }
  else {
    fin = 0;
    primero = 1;
    fill(255);
    rect(-1,-1,width+1,height+1);
    for (int i = 0; i < 13; i++) {
      for (int j = 0; j < 2; j++) {
          rayo[i][j] = 0;
      }
    }
  }
  }
cuenta++; 
finif = 0;
}
