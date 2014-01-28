
PImage f1, f2, f3, f4, f5, f0;
int[] x = new int [6]; //Position in x
int[] y = new int [6];  //Position in y
int[] xf = new int [6]; //Final position in x
int[] vel = new int[6]; //How quickly they go
int[] act = new int[6];
int cuenta = 0;
int z = 1;
float[] escala = new float [6];


void setup(){
  size(700,500);
  background(0);
  f0 = loadImage ("cara1SF.png");
  f1 = loadImage ("cara2SF.png");
  f2 = loadImage ("cara3SF.png");
  f3 = loadImage ("cara4SF.png");
  f4 = loadImage ("cara5SF.png");
  f5 = loadImage ("cara6SF.png");
  
  for (int i = 0; i < 6; i++) {
    escala[i] = 1.0;
    x[i] = 0;
    y[i] = 0;
    xf[i] = 0;
    vel[i] = 1;
  }
}

void draw(){
  println(cuenta);
  fill(0,0,0,20);
  rect(0,0,width,height);
  
  for (int i = 0; i < 6; i++) {
    if(cuenta == 80*i){
      act[i] = 1;
      y[i] = int(random(0,height-200));
      if(z == 1){
        x[i] = 0;
        xf[i] = width;
      }
      else {
        x[i] = width;
        xf[i] = 0;
      }
      vel[i] = int(random(1,4))*z;
      escala[i] = random(0.5,1.5);
      z = z*(-1);
    }
  }
  
  for(int w=0; w<6; w++){
    if(act[w] == 1){
      switch(w){
        
        case 0:
          scale(escala[w]);
          image(f0,x[w],y[w]);
          scale(1/escala[w]);
          x[w] += vel[w];
        break;
        
        case 1:
          scale(escala[w]);
          image(f1,x[w],y[w]);
          scale(1/escala[w]);
          x[w] += vel[w];
        break;
        
        case 2:
          scale(escala[w]);
          image(f2,x[w],y[w]);
          scale(1/escala[w]);
          x[w] += vel[w];
        break;
        
        case 3:
          scale(escala[w]);
          image(f3,x[w],y[w]);
          scale(1/escala[w]);
          x[w] += vel[w];
        break;
        
        case 4:
          scale(escala[w]);
          image(f4,x[w],y[w]);
          scale(1/escala[w]);
          x[w] += vel[w];
        break;
        
        case 5:
          scale(escala[w]);
          image(f5,x[w],y[w]);
          scale(1/escala[w]);
          x[w] += vel[w];
        break;
        
      }
    }
    if(x[w] < xf[w] && xf[w] == 0){
      x[w] = 0;
      y[w] = int(random(0,height-200));
      xf[w] = width;
      vel[w] = int(random(1,4));
      escala[w] = random(0.5,1.5);
    } 
    else if(x[w] > xf[w] && xf[w] == width){
      x[w] = width;
      y[w] = int(random(0,height-200));
      xf[w] = 0;
      vel[w] = int(random(1,4))*(-1);
      escala[w] = random(0.5,1.5);
    }     
  }
  cuenta++; 
}
