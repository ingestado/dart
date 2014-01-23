PVector p = new PVector (0,0);
PVector p2 = new PVector (0,0);
PVector p3 = new PVector (0,0);
int inicioCirculo = 1;
int R = 0;
int R2 = 0;
int R3 = 0;
int c2 = 0;
int c3 = 0;
int contador = 0;
int contadorTope = 0;

void setup(){
  size(500,500);
  background(0);
  
  
}

void draw(){  
  
  if (inicioCirculo == 1){
    p.x = random(0,width);
    p.y = random(0,height);
    p2.x = p.x;
    p2.y = p.y;
    p3.x = p.x;
    p3.y = p.y;
    R = int(random(0,15));
    R2 = R;
    R3 = R;
    contadorTope = int(random(60,120));
    inicioCirculo = 0;
  }
  else {
    stroke(255);
    ellipse(p.x,p.y,R,R);
    if(c2>4){
      ellipse(p2.x,p2.y,R2,R2);
    }
    if(c3>8){
      ellipse(p3.x,p3.y,R3,R3);
    }
    R++;
    if(c2>8){
      R2++;
    }
    if(c3>16){
      R3++;
    }
    c2++;
    c3++;
    contador++;
  }
  if (contador == contadorTope){
    inicioCirculo = 1;
    contador = 0;
    c2 = 0;
    c3 = 0;
  }
  
  fill(0,0,0,50);
  rect(0,0,width,height);
  
}
