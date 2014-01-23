import fisica.*;
FWorld world;

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
