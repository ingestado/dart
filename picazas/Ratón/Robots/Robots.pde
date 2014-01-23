import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PBox2D box2d;

Surface surface;
ArrayList<Robot> robots;
 
void setup() {
  size(400,300);
  
  box2d = new PBox2D(this);
  box2d.createWorld();
  
  surface = new Surface();
  robots = new ArrayList<Robot>();
  
}

void draw() {
  background(255);
  
  box2d.step();
  
   if (mousePressed) {
    Robot p = new Robot();
    robots.add(p);
  }
  
  surface.display();
  
  for (Robot b: robots) {
    b.display();
  }
  
}
