class Line {
  PVector center;
  float velocity;
  float lineSize;
  float angle;
  float global_angle;
  PShape myLine;
  
  int VTRHES = 0;
  
 // ctor
  Line(float ls) {
//    lineSize = random( 10, 100 );
    lineSize = ls;
    angle = 0.0;
    global_angle = 0.0;
    center = new PVector();
    myLine = createShape();
    myLine.beginShape(LINES);
    myLine.stroke(117,227,255);
    myLine.strokeWeight(5);
    myLine.vertex( -lineSize/2, -lineSize/2 );
    myLine.vertex( lineSize/2, lineSize/2 );
    myLine.endShape();
    birth(width/2, height/2);
  } // ctor
 
  PShape getShape() {
    return myLine; 
  }
  
  boolean checkCrash(PVector v) {
    if((abs(v.x - center.x) < lineSize/2 ) && (abs(v.y - center.y) < lineSize/2)) return true;
    else return false;
  }
  
  void birth( float x, float y ) {
    myLine.translate( -center.x, -center.y );
    myLine.translate(x, y);
    center.set(x, y, 0);
  }
 
  float getAngle() {
    return angle;
  }
 
  void setVelocity(PVector p, PVector pp) { 
    float v = p.x - pp.x + p.y - pp.y;
    velocity = v/VFACTOR;
    if(velocity > 0) velocity = min(velocity, VMAX);
    else velocity = max( velocity, -VMAX );
//    println(v);
    if(abs(v) < VMIN) velocity = VMIN;

//    println(velocity);
//    println( "p.x = " + p.x + "  pp.x = " + pp.x + " v = " + v + " velocity = " + velocity );
  }
  
  float getVelocity() {
    return velocity;
  }
 
  void update() {
   /*
   if(1) {
   } 
   */
    //println( "c.x = " + center.x + " c.y = " + center.y);
    global_angle += VMIN;
    angle += velocity;    
    angle = angle%(PI);
    myLine.translate(-center.x, -center.y);
    myLine.rotate(velocity);
    myLine.translate(center.x, center.y);
    if(velocity > VMIN) velocity-=DECELERATION;
    else if(velocity < -VMIN) velocity+=DECELERATION;
/**/
  //  if(abs(angle)<0.06 || (PI - abs(angle)) <0.06 ) {
      if(abs(velocity)  < VMIN ){
        myLine.translate(-center.x, -center.y);
        myLine.rotate(-angle + global_angle);
        myLine.translate(center.x, center.y);
        velocity = VMIN;
        angle = global_angle;        
      }
  //  }
   /**/
//    println("vel = " + velocity);
//    displayVelocity();
  }
  
  void display() {
    shape(myLine);  
  }
  
  void displayAngle() {
    fill( 255 );
    textSize( 8 );
    text( getAngle(), center.x - 10, center.y ); 
  }
  
  void displayVelocity() {
    fill( 255 );
    textSize( lineSize / 4 );
    text( getVelocity() * 1000, center.x + 10, center.y ); 
  }
  
  void mouseMoved(){
    PVector m = new PVector(mouseX, mouseY);
    PVector pm = new PVector(pmouseX, pmouseY);
    if(checkCrash(m)) {
      setVelocity(m, pm);
    }
  } 
 
}
