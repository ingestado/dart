
int[] x = new int [4]; //{x0,x2,x3,x4}
int[] y = new int [4];
int[][] jointPos = new int[15][2];   //{person}{x,y}
PVector p1 = new PVector(250,200,0);
PVector p2 = new PVector(500,200,0);

void setup(){
  size(900,600);
  background(255);
}

void draw(){
  background(0);
  
  if (mousePressed == true) {
    p1.x = mouseX;
    p1.y = mouseY;
  }
  
  for(int r=0; r<8; r++){
    change(r,int(p1.x),int(p1.y),int(p2.x),int(p2.y));
    drawLine(x[0],y[0],int(p1.x),int(p1.y),x[1],y[1],x[2],y[2],x[3],y[3],int(p2.x),int(p2.y));
  }
  fill(255,0,0);
  ellipse(int(p1.x),int(p1.y),15,15);
  ellipse(int(p2.x),int(p2.y),15,15);
}

void change(int num, int x1, int y1, int x2, int y2){
  int q = x2-x1;
  switch(num){
    case 0:
      x[0] = -q/6;
      x[1] = q/6;
      x[2] = q/3;
      x[3] = q/2;
      y[0] = 0;
      y[1] = 0;
      y[2] = 0;
      y[3] = 0;
      break;
    case 1:
      x[0] = -q/6;
      x[1] = q/6;
      x[2] = q/3;
      x[3] = q/2;
      y[0] = -15*num;
      y[1] = 15*num;
      y[2] = 20*num;
      y[3] = 25*num;
      break;
    case 2:
      x[0] = -q/6;
      x[1] = q/6;
      x[2] = q/3;
      x[3] = q/2;
      y[0] = -15*num;
      y[1] = 15*num;
      y[2] = 20*num;
      y[3] = 25*num;
      break;
    case 3:
      x[0] = -q/12;
      x[1] = q/12;
      x[2] = q/4;
      x[3] = q/2;
      y[0] = -15*num;
      y[1] = 15*num;
      y[2] = 20*num;
      y[3] = 25*num;
      break;
    case 4:
      x[0] = 0;
      x[1] = 0;
      x[2] = q/6;
      x[3] = q/2;
      y[0] = -15*num;
      y[1] = 15*num;
      y[2] = 20*num;
      y[3] = 25*num;
      break;
    case 5:
      x[0] = +q/15;
      x[1] = -q/15;
      x[2] = q/12;
      x[3] = q/2;
      y[0] = -15*3-5;
      y[1] = 15*3+5;
      y[2] = 20*num;
      y[3] = 25*num;
      break;
    case 6:
      x[0] = q/6;
      x[1] = -q/6;
      x[2] = 0;
      x[3] = q/2;
      y[0] = -15*2;
      y[1] = 15*2;
      y[2] = 20*5+5;
      y[3] = 25*num;
      break;
    case 7:
      x[0] = q/4;
      x[1] = -q/4;
      x[2] = -q/6;
      x[3] = q/2;
      y[0] = -15;
      y[1] = 15;
      y[2] = 20*6;
      y[3] = 25*num;
      break;
      
  }
}

void drawLine(int x0, int y0, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int x7, int y7){
    noFill();
    stroke(255);
    beginShape();
    curveVertex(x1+x0,y1+y0);
    curveVertex(x1,y1);
    curveVertex(x1+x2,y1+y2);
    curveVertex(x1+x3,y1+y3);
    curveVertex(x1+x4,y1+y4);
    curveVertex(x7-x3,y7+y3);
    curveVertex(x7-x2,y7+y2);
    curveVertex(x7,y7);
    curveVertex(x7+x0,y7+y0);
    endShape();
    noFill();
    stroke(255);
    beginShape();
    curveVertex(x1+x0,y1-y0);
    curveVertex(x1,y1);
    curveVertex(x1+x2,y1-y2);
    curveVertex(x1+x3,y1-y3);
    curveVertex(x1+x4,y1-y4);
    curveVertex(x7-x3,y7-y3);
    curveVertex(x7-x2,y7-y2);
    curveVertex(x7,y7);
    curveVertex(x7+x0,y7-y0);
    endShape();
}
