class Ring3 {

  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float xsize;
  float ysize; 

  Ring3(float xp, float yp, float velx, float vely) {
    xpos = xp;
    ypos = yp;
    xvel = velx;
    yvel = vely;

    xsize = 40;
    ysize = xsize;
  }

  void draw () {
    ellipseMode(CENTER);
    fill(0,150,200);
    noStroke();
    ellipse(xpos, ypos, xsize, ysize);
  }

  void drive () {
    xpos = xpos + xvel;
    if (xpos > width + xsize) { 
  xpos = -xsize+40-20; 
    }
    ypos = ypos + yvel;
    if (ypos > width + ysize) { 
  ypos = -ysize+40-20; 
    }
  }
}
