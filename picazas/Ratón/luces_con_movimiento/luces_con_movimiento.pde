
PVector before = new PVector(0,0,0);
PVector after = new PVector(0,0,0);
int count = 0;

void setup(){
  size(700,500,P3D);
  background(255);
}

void draw(){
  background(0);
  if(count==3){
    after.x = before.x;
    after.y = before.y;
    before.x = mouseX;
    before.y = mouseY;
    count = 0;
  }
  else count++;
  
  fill(255,0,0);
  stroke(0);
  ellipse(after.x,after.y,15,15);
  if(after.x-before.x>0 ||after.y-before.y>0 ||before.x-after.x>0 ||before.y-after.y>0 ){
  drawLine(int(after.x),int(after.y));
  }
}

void drawLine(int x,int y){
  for(int r=0; r<20; r++){
    int wi = int(random(-100,width+100));
    int hi = int(random(-100,height+100));
    fill(255);
    strokeWeight(4);
    stroke(255,255,255,60);
    line(wi,-50,x,y);
    line(x,y,0,width-wi,height+50,150);
    line(-50,hi,x,y);
    line(x,y,0,width+50,height-hi,150);
  }
}
