import fisica.*;
FWorld world;

int cuentaB = 0;
int cuentaT = 0;

void setup() {
  size(640, 480);
  smooth();
  
    Fisica.init(this);

  world = new FWorld();
  world.setEdges();
  world.remove(world.top);

  FCircle bola = new FCircle(40);
  bola.setPosition(width/3, height/2); //Begin position
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola);
  
}

void draw() {
  background(255);
  cuentaT++;
  if (cuentaB < 51 && cuentaT == 30){
  float radius = random(20, 40);
  FCircle bola = new FCircle(radius);
  bola.setPosition(random(30,640), random(30,100));
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola); 
  cuentaT = 0; 
  cuentaB ++;
  }
  world.step();
  world.draw();
}

void mousePressed() {
  float radius = random(10, 40);
  FCircle bola = new FCircle(radius);
  bola.setPosition(mouseX, mouseY);
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola);  
}
