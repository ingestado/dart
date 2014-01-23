class Surface {
  ArrayList<Vec2> surface;
 
  Surface() {
 
    surface = new ArrayList<Vec2>();       //3 vertices in pixel coordinates
    surface.add(new Vec2(0, height/2+50));
    surface.add(new Vec2(width/2, height/2+50));
    surface.add(new Vec2(width, height/2));
 
    ChainShape chain = new ChainShape();
    
    //Make an array of Vec2 for the ChainShape.
    Vec2[] vertices = new Vec2[surface.size()];
 
 
    for (int i = 0; i < vertices.length; i++) {
      //Convert each vertex to Box2D World coordinates.
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }
 
    //Create the ChainShape with array of Vec2.
    chain.createChain(vertices, vertices.length);
 
    //Attach the Shape to the Body.
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
  }
  
  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    //Draw the ChainShape as a series of vertices.
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x,v.y);
    }
    endShape();
  }
}
