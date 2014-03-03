class Ring1 {

  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float xsize;
  float ysize; 

  Ring1(float xp, float yp, float velx, float vely) {

    xpos = xp;
    ypos = yp;
    xvel = velx;
    yvel = vely;

    xsize = 20;
    ysize = xsize;
  }

  void draw () {
    ellipseMode(CENTER);
   // fill(0,100,255);
    fill(0,255,0);
    noStroke();
    ellipse(xpos, ypos, xsize, ysize);
  }

  void drive () {
    xpos = xpos + xvel;
    if (xpos > width + xsize) { 
  xpos = -xsize-20; 
    }
    ypos = ypos + yvel;
    if (ypos > width + ysize) { 
  ypos = -ysize-20; 
    }
  }
}

