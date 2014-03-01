
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
  if(after.x-before.x>10 ||after.y-before.y>10 ||before.x-after.x>10 ||before.y-after.y>10 ){
  drawLine(int(after.x),int(after.y));
  }
}

void drawLine(int x,int y){
  
  for(int r=0; r<40; r++){ 
    pushMatrix(); 
    float w = random(0,180);
    translate(x,y,0);
    rotateZ(radians(w));  
    fill(255);
    strokeWeight(20);
    stroke(255,255,255,30);
    rectMode(CENTER);
    rect(0,0,2,4*width);
    popMatrix();
  }
}
