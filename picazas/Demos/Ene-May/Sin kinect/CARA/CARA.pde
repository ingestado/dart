PImage f1;
int x;
int y;
int xf;
int vel;
int act;
int cuenta = 0;
int z = 1;
float escala;

void setup(){
  size(700,500);
  background(0);
  f1 = loadImage ("cara1SF.png");
}

void draw(){
  println(cuenta);
  println("( " + x + " , " + y + " ) ");
  println("escala: " + escala);
  println(xf);
  println(vel);
  fill(0,0,0,20);
  rect(0,0,width,height);
  
  if(cuenta == 80){
    
    escala = random(0.5,1.5);
    act = 1;
    y = int(random(0,height-200));
    x = 0;
    xf = width;
    vel = int(random(1,4))*z;
    z = z*(-1);
  }
  cuenta++;
  
  scale(escala);
  image(f1,x,y);
  scale(1/escala);  
  x += vel;
  
  if(x < xf && xf == 0){
      x = 0;
      y = int(random(0,height-200));
      xf = width;
      vel = int(random(1,4));
      escala = random(0.5,1.5);
    } 
    else if(x > xf && xf == width){
      x = width;
      y = int(random(0,height-200));
      xf = 0;
      vel = int(random(1,4))*(-1);
      escala = random(0.5,1.5);
    }     
    
}
