int[][] p = new int[4][2];
int[][] p2 = new int[4][2];
int[][] p3 = new int[4][2];
int[] inicioCirculo = {1,1,1,1};
int[] R = new int[4];
int[] R2 = new int[4];
int[] R3 = new int[4];
int[] c2 = new int[4];
int[] c3 = new int[4];
int tiempo = 0;
int[] contador = new int[4];
int[] contadorTope = {90,90,90,90};

void setup(){
  
  size(500,500);
  background(0);
  
}

void draw(){  
  
  println("Tiempo: " + tiempo);
  
  if (tiempo<50 && tiempo>0){
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
  }
  
  else if (tiempo>49 && tiempo<100){
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
  }
  
   else if (tiempo>99 && tiempo<150){
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
  }
  
   else if (tiempo>149 && tiempo<200){
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
  }
  else {tiempo = 0;}
  
/////////////////////////////////////////////////////////////////////
//Circulo 1

      stroke(255);
      ellipse(p[0][0],p[0][1],R[0],R[0]);
      if(c2[0]>4){
        ellipse(p2[0][0],p2[0][1],R2[0],R2[0]);
      }
      if(c3[0]>8){
        ellipse(p3[0][0],p3[0][1],R3[0],R3[0]);
      }
      R[0]++;
      if(c2[0]>8){
        R2[0]++;
      }
      if(c3[0]>16){
        R3[0]++;
      }
      c2[0]++;
      c3[0]++;
      contador[0]++;
      
      if (contador[0] == contadorTope[0]){
      inicioCirculo[0] = 1;
      contador[0] = 0;
      c2[0] = 0;
      c3[0] = 0;
      }
      
//////////////////////////////////////////////////////////////////
//Circulo 2
      
      stroke(255);
      ellipse(p[1][0],p[1][1],R[1],R[1]);
      if(c2[1]>4){
        ellipse(p2[1][0],p2[1][1],R2[1],R2[1]);
      }
      if(c3[1]>8){
        ellipse(p3[1][0],p3[1][1],R3[1],R3[1]);
      }
      R[1]++;
      if(c2[1]>8){
        R2[1]++;
      }
      if(c3[1]>16){
        R3[1]++;
      }
      c2[1]++;
      c3[1]++;
      contador[1]++;
      
      if (contador[1] == contadorTope[1]){
      inicioCirculo[1] = 1;
      contador[1] = 0;
      c2[1] = 0;
      c3[1] = 0;
      }
      
//////////////////////////////////////////////////////////////////////////
//Circulo 3
      
      stroke(255);
      ellipse(p[2][0],p[2][1],R[2],R[2]);
      if(c2[2]>4){
        ellipse(p2[2][0],p2[2][1],R2[2],R2[2]);
      }
      if(c3[2]>8){
        ellipse(p3[2][0],p3[2][1],R3[2],R3[2]);
      }
      R[2]++;
      if(c2[2]>8){
        R2[2]++;
      }
      if(c3[2]>16){
        R3[2]++;
      }
      c2[2]++;
      c3[2]++;
      contador[2]++;
      
      if (contador[2] == contadorTope[2]){
      inicioCirculo[2] = 1;
      contador[2] = 0;
      c2[2] = 0;
      c3[2] = 0;
      }
      
////////////////////////////////////////////////////////////////////////////////////
//Circulo 4
      
      stroke(255);
      ellipse(p[3][0],p[3][1],R[3],R[3]);
      if(c2[3]>4){
        ellipse(p2[3][0],p2[3][1],R2[3],R2[3]);
      }
      if(c3[3]>8){
        ellipse(p3[3][0],p3[3][1],R3[3],R3[3]);
      }
      R[3]++;
      if(c2[3]>8){
        R2[3]++;
      }
      if(c3[3]>16){
        R3[3]++;
      }
      c2[3]++;
      c3[3]++;
      contador[3]++;
      
      if (contador[3] == contadorTope[3]){
      inicioCirculo[3] = 1;
      contador[3] = 0;
      c2[3] = 0;
      c3[3] = 0;
    }
    
  for (int w = 0; w < 4; w++){
    if (R[w]>130){
      R[w] = 0;
      R2[w] = 0;
      R3[w] = 0;
      inicioCirculo[w] = 1;
    }
  }
   
  tiempo++;
  fill(0,0,0,50);
  rect(0,0,width,height);
  
}
