import fisica.*;
FWorld world;

float x, y;
float[] X= new float[20];
int cuenta = 0;

void setup() {
  size(640, 480);
  smooth();
  
  Fisica.init(this);

  world = new FWorld();

  FCircle bola = new FCircle(40);
  bola.setPosition(width/3, height/2); //Begin position
  cuenta = 1;
  X[1]=40;
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola);
  

}

void draw() {
  background(255);
  bola.setPorition(x,y);
  for (int w = 0; w < cuenta; w++){
  x = x + X[w];
    if (y==480){
     adjustVelocity(x,-y);  
    }
  }
  world.step();
  world.draw();
}

void mousePressed() {
  if (cuenta < 20){
  float radius = random(10, 40);
  FCircle bola = new FCircle(radius);
  bola.setPosition(mouseX, mouseY);
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola);  }
}
