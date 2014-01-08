PVector jointPos = new PVector(0,0,0);
color c = color(255, 0, 0);


void setup(){
  size(1000,650);
  background(0,255,0);

}

void draw(){
  
  fill(0,255,0,10);
  rect(0,0,width, height);
  
  for ( int h=0; h<20; h++){
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(-50,width+50),random(-50,0));
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(-50,width+50),random(height,height+50));
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(-50,0),random(-50,height+50));
    fill(255,0,0);
    line(jointPos.x,jointPos.y,random(width,width+50),random(-50,height+50));
  }

}
