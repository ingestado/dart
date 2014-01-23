import fisica.*;
FWorld world;
FWorld persona;

import SimpleOpenNI.*;
SimpleOpenNI kinect;

int clickedDepth,clickPosition;
int cuentaB = 0;
int cuentaT = 0;
int cuentaP = 0;
int cuentaY = 0;
int yant, yact;

void setup() {
  size(640, 480);
  smooth();
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  Fisica.init(this);
  
  persona = new FWorld();
  persona.setEdges();


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
  
  int[] depthValues = kinect.depthMap();  //Save the Depth's values in an array
  for(int y = 0; y < 480; y++){    //See all the pixels
  if (cuentaY == 10){ cuentaY=0;}
  cuentaY++;
    for(int x = 0; x < 640; x++){ 
      clickPosition = x + (y*640);        //We see which pixel we are working on
      clickedDepth = depthValues[clickPosition];  //See the pixel's value 
      if (clickedDepth > 500 && clickedDepth<2000){
        cuentaP ++;
        if(cuentaP == 10 && cuentaY == 10){
         cuentaP = 0;
         FCircle ParteCuerpo = new FCircle(10);
         ParteCuerpo.setPosition(x, y);
         ParteCuerpo.setDensity(2);
         ParteCuerpo.setFill(0);
         persona.add(ParteCuerpo); 
        }
      }    
    }
  }
  
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
  
  PImage depthImage = kinect.depthImage();
  image(depthImage,0,0);        //Draw the depth image
  world.step();
  world.draw();
  persona.step();
  persona.draw();
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
