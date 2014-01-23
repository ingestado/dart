class Luz{
  
  Body body;
  
  Luz(float x, float y){
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(3);
    
    FixtureDef fd = new FixtureDef();
    fd.shape=cs;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
  }
  
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    pushMatrix();
    translate(pos.x,pos.y);
    fill(255,255,255,200);
    stroke(19);
    fill(255);
    ellipse(0,0,10,10);
    popMatrix();
  }
  
  void killBody(){
    box2d.destroyBody(body);
  }
  
} 
