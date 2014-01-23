
  BodyDef bd = new BodyDef();
  Vec2 center = new Vec2(width/2,height/2);
  bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));
  bd.bullet = true;
  Body body = box2d.createBody(bd);
  
  PolygonShape ps = new PolygonShape();
  float bosx2Dw = box2d.scalarPixelsToWorld(150);
  float bosx2Dh = box2d.scalarPixelsToWorld(100);
  ps.setAsBox(bosx2Dw,bosx2Dh);
  
  FixtureDef fd = new FixtureDef();
  fd.shape = ps;
  fd.friction = 0.3; //The Shape’s restitution (i.e. elasticity), typically between 0 and 1
  fd.restitution = 0.5; //The Shape’s density, measured in kilograms per meter squared
  fd.density = 1.0;
  
  body.createFixture(fd);
