
PImage f1, f2, f3;
int[] x = new int [3];
int[] y = new int [3];
int[] x1 = new int [3];
int[] s = new int[3];
int[] activado = new int[3];
int[] max = new int[3];
int palabra = 0;
int numero = 0;
int cuenta = 0;


void setup(){
  size(700,500);
  background(0);
  f1 = loadImage ("cara1.jpg");
  f2 = loadImage ("cara2.jpg");
  f3 = loadImage ("cara3.jpg");
  
  for (int i = 0; i < 3; i++) {
    s[i] = 32;
    x[i] = 0;
    y[i] = 0;
    x1[i] = 0;
    activado[i] = 0;
  }
}

void draw(){
  
  fill(0,0,0,10);
  rect(0,0,width,height);
  
  if(cuenta == 40){
    numero++;
    activado [numero] = 1;
    cuenta = 0;
    max[numero] = int(random(60,80));
    x1[numero] = int(random(0,width-50));
    y[numero] = int(random(0,height-50));
    x[numero] = x1[numero];
  }
  
  for(int w=0; w<3; w++){
    if (activado[w] == 1){
      switch(w){
        
        case 0:
          image(f1,x[0],y[0]);
        break;
        
        case 1:
          scale(0.5);
          image(f2,x[1],y[1]);
        break;
        
        case 2:
          image(f3,x[2],y[2]);
        break;
        
      }
    }
  }
  for (int i = 0; i < 3; i++) {
    
    if(activado[i] == 1){
      s[i]++;
      x[i]--;
    }
    
    if (s[i] > max[i]){
      activado[i] = 0;
      s[i] = 32;
      x[i] = 0;
      y[i] = 0;
      x1[i] = 0;
    }
  }
  if(numero==2){
    numero = 0;
  }
  cuenta++;
  
  
}
