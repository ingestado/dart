class Ring1 {

  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float xvel2;
  float yvel2;
  float xvel3;
  float yvel3;
  float size;
  float size2;
  float size3; 

  Ring1(float xp, float yp, float velx, float vely) {

    xpos = xp;
    ypos = yp;
    xvel3 = -velx;
    yvel3 = -vely;
    xvel2 = velx;
    yvel2 = vely;

    size = 20;
    size2 = 30;
    size3 = 40;
    
  }

  void draw () {
    ellipseMode(CENTER);
   // fill(0,100,255);
    fill(255,255,255);
    noStroke();
    ellipse(xpos, ypos, size2, size2); 
    fill(0,150,200);
    noStroke();
    ellipse(xpos, ypos, size3, size3);
    fill(0,255,0);
    noStroke();
    ellipse(xpos, ypos, size, size);
    
  }

  void drive () {
    xpos = xpos + xvel;
    ypos = ypos + yvel;
    float rx = mouseX-xpos;
    if (rx<0) { rx=rx*(-1);}
    float ry = mouseY-ypos;
    if (ry<0) { ry=ry*(-1);}
    
    if (rx<10 && ry<10) { 
        xpos = -size-random(0,width); 
        ypos = -size-random(0,height);
    }
  }
  
  void changeVel(){
    float dx = mouseX - xpos;
    float dy = mouseY - ypos;
    if (dx<0){
      xvel = xvel3;
    }
    else xvel = xvel2;
    if (dy<0){
      yvel = yvel3;
    }
    else yvel = yvel2;
  }
}

