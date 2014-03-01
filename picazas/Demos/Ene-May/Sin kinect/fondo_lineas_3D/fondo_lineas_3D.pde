


void setup(){
  size(700,500,P3D);
  background(0);
  for (int r=0; r<100; r++){
    /*float xi = random(0,width);
    float xf = random(0,width);
    float yi = random(0,height);
    float yf = random(0,height);
    float zi = random(0,500);
    float zf = random(0,500);*/
    float x = int(random(0,width));
    float y = int(random(0,height));
    float z = int(random(0,500));
    float xr = random(0,270);
    float yr = random(0,270);
    float zr = random(0,270);
    pushMatrix();
    translate(x,y,z);
    rotateX(radians(xr));
    rotateY(radians(yr));
    rotateZ(radians(zr));
    fill(255);
    //strokeWeight(10);
    stroke(255,255,255,30);
    rectMode(CENTER);
    rect(0,0,2,1500);
    popMatrix();
  }
}

void draw(){
  
}
  
