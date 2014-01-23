int XC = 0;
int YC = 0;


void setup(){
  
  size(700,500);
  background(0);
  
  fill(255,0,0);
  rect(width-width/5,0,width,height/6);
  fill(0,255,0);
  rect(width-width/5,height/6,width,height/3);
  fill(0,0,255);
  rect(width-width/5,height/3,width,height/2);
  fill(125,0,125);
  rect(width-width/5,height/2,width,4*height/6);
  fill(125,125,0);
  rect(width-width/5,4*height/6,width,5*height/6);
  fill(0,125,125);
  rect(width-width/5,5*height/6,width,height);
  
  fill(200);
  rectMode(CENTER);
  rect(width-width/10,height/12,width/10,height/12);
  fill(200);
  rectMode(CENTER);
  rect(width-width/10,3*height/12,height/12,width/10);
  fill(200);
  rectMode(CENTER);
  rect(width-width/10,5*height/12,height/12,height/12);
  fill(200);
  ellipseMode(CENTER);
  ellipse(width-width/10,7*height/12,height/12,height/12);
  fill(200);
  beginShape();
  vertex(width-30-width/10,9+9*height/12);
  vertex(width+30-width/10,9+9*height/12);
  vertex(width-width/10,-18+9*height/12);
  endShape();
  fill(200);
  beginShape();
  vertex(width-width/10, -25+11*height/12);
  vertex(7+width-width/10, -10+11*height/12);
  vertex(22.5+width-width/10, -7.5+11*height/12);
  vertex(11.5+width-width/10, 3.5+11*height/12);
  vertex(15.5+width-width/10, 20+11*height/12);
  vertex(width-width/10, 12.5+11*height/12);
  vertex(-15.5+width-width/10, 20+11*height/12);
  vertex(-11.5+width-width/10, 3.5+11*height/12);
  vertex(-23.5+width-width/10, -7.5+11*height/12);
  vertex(-7+width-width/10, -10+11*height/12);
  endShape(CLOSE);
    
  fill(255,0,0);
  ellipseMode(CENTER);
  ellipse(width-2.5*width/7,5+width/7,width/7,width/7);
  fill(255,0,0);
  ellipseMode(CENTER);
  ellipse(width-2.5*width/7,width/7,width/7,width/7);
  fill(200);
  rect(25+width/4,width/6,width/2,width/25);
  
}

void draw(){
  fill(255);
  rectMode(CENTER);
  rect(XC+25,width/6,20,40);
  
}
