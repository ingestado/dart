float VTHRES = 120;  // v as diff of points positions. beyond vthres is considered no-movement

class ElementSystem {

  ArrayList elements;
 
  // ctor
  ElementSystem() {
    elements = new ArrayList();
  }  // ctor

  void addElement(PVector loc) {
    addElement( loc.x, loc.y );  
  }

  void addElement( float x, float y ) {
    addElement(new PVector(x, y), new PVector(random(-1, 1), random(-3)) ); 
  }

  void addElement(PVector loc, PVector vel) {
    elements.add( new Element(loc, vel) );  
  }
  
  void popElements(PVector p, PVector pp) {
    float v = p.x - pp.x + p.y - pp.y;
    float n = random(1);
    for(int i = 0; i < n; i++) {
//    new Element(mouseX, mouseY)
      if(abs(v) < VTHRES) addElement(p.x, p.y);
//    ellipseMode(RADIUS);
//    ellipse(mouseX, mouseY, 20, 20);
    }  
  }

  void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for( int i = elements.size()-1; i >= 0; i-- ) {
      Element p = (Element) elements.get(i);
      p.run();
      if (p.isdead()) {
        elements.remove(i);
      }
    }
  }
  
  
  boolean isdead() {
    if(elements.isEmpty()) {
      return true;
    } else {
      return false; 
    }
  }
  
} // end class
