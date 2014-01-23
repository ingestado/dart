import fisica.*;
FWorld world;

import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuentaB = 0;
int cuentaT = 0;
PVector manoDer = new PVector();
int MD,MDE,q,w;

void setup() {
  size(640, 480, P3D);
  smooth();
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  
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
  
  kinect.update();
  int[] userMap = kinect.userMap();
  q = q + 15;
  w = w + 15;
  /* FCircle bolam = new FCircle(40);
  bolam.setPosition(15, 15); //Begin position
  bolam.setDensity(0.2);
  bolam.setFill(120, 120, 190);
  bolam.setNoStroke();
  world.add(bolam);
  bolam.setPosition(q,w);*/
  
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

  ArrayList cuerpos = world.getBodies();
  println(cuerpos);

  
  image(kinect.userImage(),0,0);
      
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
