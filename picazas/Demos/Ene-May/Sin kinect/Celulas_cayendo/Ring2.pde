class Ring2 {

  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float xsize;
  float ysize; 
  
  Ring2(float xp, float yp, float velx, float vely) {
    xpos = xp;
    ypos = yp;
    xvel = velx;
    yvel = vely;

    xsize = 30;
    ysize = xsize;
  }

  void draw () {
    ellipseMode(CENTER);
    fill(255,255,255);
    noStroke();
    ellipse(xpos, ypos, xsize, ysize);
  }

  void drive () {
    xpos = xpos + xvel;
    if (xpos > width + xsize) { 
  xpos = -xsize+20-20; 
    }
    ypos = ypos + yvel;
    if (ypos > width + ysize) { 
  ypos = -ysize+20-20; 
    }
  }

}
