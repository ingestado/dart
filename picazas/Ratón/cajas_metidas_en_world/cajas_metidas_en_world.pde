import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PBox2D box2d;

ArrayList<Box> boxes;
ArrayList<Boundary> Boundaries;

Surface surface;
 
void setup() {
  size(400,300);
  
  box2d = new PBox2D(this);
  box2d.createWorld();
  
  surface = new Surface();
  
  boxes = new ArrayList<Box>();
  Boundaries = new ArrayList<Boundary>();
  Boundary b1 = new Boundary(120,120,100,100);
  Boundary b2 = new Boundary(340,300,50,120);
  Boundaries.add(b1);
  Boundaries.add(b2);
  
}
 
void draw() {
  background(255);
  
  box2d.step();
  

//When the mouse is pressed, add a new Box object.
  if (mousePressed) {
    Box p = new Box();
    boxes.add(p);
  }
 
  surface.display();
   for (Box b: boxes) {
    b.display();
  }
  for (Boundary d: Boundaries) {
    d.display();
  }
  
}
