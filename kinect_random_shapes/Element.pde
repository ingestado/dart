int SIZE_MIN = 5;
int SIZE_MAX = 25;
float ACC = 0.03;
int VEL;

class Element {
  PVector loc;
  float ang;
  float w;  // angular velocity
  PVector vel;
  PVector acc;
  float size;  // size  
  float timer;
  color c;  // color
  float a; //alpha value
  int type;// ELLIPSE, LINE, QUAD, TRIANGLE, or SHAPE
  
  // ctor  
  Element(PVector localization, PVector velocity) {
    acc = new PVector(0, ACC, 0);
    w = radians(20);
    loc = localization.get();
    timer = 700.0;
//    ang = angle;
  /* random params at the creation */
 //   vel = new PVector(random(-1, 1), random(-3));
    vel = velocity;
    size = random(SIZE_MIN, SIZE_MAX);  
    ang = radians(random(360));  
    
    // type
    int n = round(random(3));
    n = 0;
    switch(n) {
      case 0:
        type = ELLIPSE;
        break;
      case 1:
        type = QUAD;
        break;
      case 2:
        type = TRIANGLE;
        break;
      case 3:
        break;     
    }
    // color
    int r = round(random(256));
    int g = round(random(256));
    int b = round(random(256));
    int a = round(random(256)); //0 transparent
    c = color(r, g, b, a);
    
  }
  
  // Method to update location and angle
  void update() {
    vel.add(acc);
    loc.add(vel);
    ang += w;
    timer -= 1.0;
  }
  
  // Method to display
  void display() {

//      pushMatrix();
//    translate(loc.x,loc.y);
//    rotate(ang);
    //draw
    fill(c);
    switch(type) {
      case ELLIPSE :
        ellipseMode(RADIUS);
        noStroke();
        ellipse(loc.x, loc.y, size, size);
//        ellipse(width/2, height/2, 200, 200);
        break;  
    }
//    popMatrix();   
  }
  
  void run() {
    update();
    display();
  }

  boolean isdead() {
    if( timer <= 0.0 ) {
      return true;
    } else {
      return false; 
    }
  }
  
} // class end
