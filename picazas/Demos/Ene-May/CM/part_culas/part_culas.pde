int x,y;
int vx = 0;
int vx = 0;

void setup(){
  size(600,500);
  background(255);
  x=width/2;
  y=height/2;
}

void draw(){
  fill(200,0,0);
  ellipse(width/2,height/2,10,10);
  ellipse(x,y,2,2);
  
  vx = int(random(1,5));
  vy = int(random(1,5));
  x += vx;
  y += vy;
  
  if(x+1 == width){
    vx = int(random(-5,-1));
  }
  else if(x-1 == 0){
    vx = int(random(1,5));
  }
  else if(y+1 == height){
    vy = int(random(-5,-1));
  }
  else if(y-1 == 0){
    vy = int(random(1,5));
  }
}
