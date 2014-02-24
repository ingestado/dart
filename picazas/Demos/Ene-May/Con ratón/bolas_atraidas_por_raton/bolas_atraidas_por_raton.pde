
import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PBox2D box2d;

PVector now = new PVector(0,0,0);
PVector before = new PVector(0,0,0);
ArrayList<Boundary> boundaries;
ArrayList<Particle> particles;

void setup() {
  size(640,360);
  smooth();

  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);

  particles = new ArrayList<Particle>();
  boundaries = new ArrayList<Boundary>();

  boundaries.add(new Boundary(width/2,0,width,10));
  boundaries.add(new Boundary(0,height/2,10,height));
  boundaries.add(new Boundary(width/2,height-5,width,10));
  boundaries.add(new Boundary(width-5,height/2,10,height));
  
  for(int r=0; r<25; r++){
    Particle p = new Particle(random(width),random(height),random(2,10));
    particles.add(p);
  }
  
}

void draw() {
  background(255);
  box2d.step();
  
  now.x = mouseX;
  now.y = mouseY;
  
  if ((before.x-now.x)==0 || (before.y-now.y)==0) {
    for (Particle b: particles) {
      b.attract(now.x,now.y);
    }
  }
  else{
    for (Particle b: particles) {
      b.attract(random(0,width),random(0,50));
    }
  }

  for (Boundary wall: boundaries) {
    wall.display();
  }

  for (Particle b: particles) {
    b.display();
  }

  for (int i = particles.size()-1; i >= 0; i--) {
    Particle b = particles.get(i);
    if (b.done()) {
      particles.remove(i);
    }
  }
  before.x = now.x;
  before.y = now.y;
}




