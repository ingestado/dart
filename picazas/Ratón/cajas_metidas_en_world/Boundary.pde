class Boundary{
  
 float x,y,w,h;  
 Body b;
 
 Boundary(float x1,float y1, float w1, float h1){
  x=x1;
  y=y1;
  w=w1;
  h=h1;
  
  BodyDef bd= new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(x,y));
  bd.type = BodyType.STATIC;
  b = box2d.createBody(bd);
  
  float box2dW = box2d.scalarPixelsToWorld(w/2);
  float box2dH = box2d.scalarPixelsToWorld(h/2);
  PolygonShape ps = new PolygonShape();
  ps.setAsBox(box2dW, box2dH);
  b.createFixture(ps,1);
  
 }
 
 void display(){
   fill(0);
   stroke(0);
   rectMode(CENTER);
   rect(x,y,w,h);
 }
 
}

