class LineSystem {

  ArrayList<Line> lines;  
  PShape lineShape;
  
  // ctor
  LineSystem( int n, int m ) {
    PVector o = new PVector(0, 0);
    lines = new ArrayList<Line>();
    lineShape = createShape(GROUP);
    for( int i = 0; i < n; i++ ) {
      for( int j = 0; j < m; j++ ) {
        Line l = new Line(max(width/n, height/m));
        o.y = o.y + height/m;
        l.birth(o.x, o.y);
        lines.add(l);
        lineShape.addChild(l.getShape());
      }
      o.y = 0;
      o.x = o.x + width/n;
    }
  } // ctor
  
  void update() {
   for( Line l : lines ) {
    l.update();
   } 
  }
  
  void checkCrashes(PVector p, PVector pp) {
    for(Line l :lines) 
      if(l.checkCrash(p) || l.checkCrash(pp)) { 
        l.setVelocity(p, pp);  
//        println( "p.x = " + p.x + "  pp.x = " + pp.x + " dif = " + (p.x - pp.x) );
      }
  }
  
  void mouseMoved() {
    for( Line l : lines ) {
      l.mouseMoved();
    }
  }
  
  void display() {
    shape( lineShape );
  }
  
  void displayAngles() {
    for( Line l : lines ) {
      l.displayAngle();
    }
  }
}
