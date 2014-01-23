class Robot{
  
  Body body;
  
  Robot(float x, float y){
  
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(x,y));
  body = box2d.createBody(bd);
  
  PolygonShape cr = new PolygonShape();
  float box2dW0 = box2d.scalarPixelsToWorld(8);
  float box2dH0 = box2d.scalarPixelsToWorld(8);
  cr.setAsBox(box2dW0, box2dH0);
  
  CircleShape cs = new CircleShape();
  cs.m_radius = box2d.scalarPixelsToWorld(3);
  
  PolygonShape pi = new PolygonShape();
  float box2dW1 = box2d.scalarPixelsToWorld(3);
  float box2dH1 = box2d.scalarPixelsToWorld(6);
  pi.setAsBox(box2dW1, box2dH1);
  
  PolygonShape pd = new PolygonShape();
  float box2dW2 = box2d.scalarPixelsToWorld(3);
  float box2dH2 = box2d.scalarPixelsToWorld(6);
  pd.setAsBox(box2dW2, box2dH2);
  
  PolygonShape ai = new PolygonShape();
  float box2dW3 = box2d.scalarPixelsToWorld(2);
  float box2dH3 = box2d.scalarPixelsToWorld(4);
  ai.setAsBox(box2dW3, box2dH3);
  
  PolygonShape ad = new PolygonShape();
  float box2dW4 = box2d.scalarPixelsToWorld(2);
  float box2dH4 = box2d.scalarPixelsToWorld(4);
  ad.setAsBox(box2dW4, box2dH4);
  
  body.createFixture(cr,1.0);
  body.createFixture(cs, 1.0);
  body.createFixture(pi,1.0);
  body.createFixture(pd, 1.0);
  body.createFixture(ai,1.0);
  body.createFixture(ad, 1.0);
  
  Vec2 offsetcs = new Vec2(0,-7);
  offsetcs = box2d.vectorPixelsToWorld(offsetcs);
  cs.m_p.set(offsetcs.x,offsetcs.y);
 /*
  Vec2 offsetpi = new Vec2(-3,7);
  offsetpi = box2d.vectorPixelsToWorld(offsetpi);
  pi.m_p.set(offsetpi.x,offsetpi.y);
  
  Vec2 offsetpd = new Vec2(3,7);
  offsetpd = box2d.vectorPixelsToWorld(offsetpd);
  pd.m_p.set(offsetpd.x,offsetpd.y);
  
  Vec2 offsetai = new Vec2(-3,-7);
  offsetai = box2d.vectorPixelsToWorld(offsetai);
  ai.m_p.set(offsetai.x,offsetai.y);
  
  Vec2 offsetad = new Vec2(3,-7);
  offsetad = box2d.vectorPixelsToWorld(offsetad);
  ad.m_p.set(offsetad.x,offsetad.y);*/
  
  body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
  body.setAngularVelocity(random(-5, 5));
  
}

void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
 
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0,0,8,8);
    ellipse(0,-8,3*2,3*2);
    rect(3,7,3,6);
    rect(-3,7,3,6);
    rotate(-45);
    rect(7,-10,2,4);
    rotate(90);
    rect(-7,-10,2,4);
    popMatrix();
  }
  
}
