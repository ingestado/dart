import SimpleOpenNI.*;
SimpleOpenNI kinect;

import fisica.*;
FWorld world;



int cuentaB = 0;
int cuentaT = 0;
PVector p= new PVector (0,0);      //Create a vector to save the pixel's position
int clickedDepth,clickPosition;
int maxValue;

void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI (this);
  kinect.enableDepth();
  
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
  kinect.update();
  background(255);
  cuentaT++;
  
  maxValue = 8000;
  p.x=0;
  p.y=0;
  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];    //See the pixel's value 
      if (clickedDepth > 455){
      if (maxValue > clickedDepth){
        maxValue = clickedDepth;      //If is the nearest pixel, we save its position
        p.x = x;
        p.y = y;}}
    }
  }
  FCircle mano = new FCircle(30);
  mano.setDensity(0.2);
  mano.setFill(255,0,0);
  mano.setNoStroke();
  mano.setPosition(p.x,p.y);
  world.add(mano);
  
  if (cuentaB < 51 && cuentaT == 30){
  float radius = random(20, 40);
  FCircle bola = new FCircle(radius);
  bola.setPosition(random(30,640), random(30,100));
  bola.setDensity(0.05);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola); 
  cuentaT = 0; 
  cuentaB ++;
  }
  
  world.step();
  world.draw();
  world.remove(mano);
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
