
PFont f;
int[] x = new int [20];
int[] y = new int [20];
int[] x1 = new int [20];
int[] s = new int[20];
int[] activado = new int[20];
int[] max = new int[20];
int palabra = 0;
int numero = 0;
int cuenta = 0;


void setup(){
  size(700,500);
  background(0);
  f = createFont ("Arial",16,true);
  
  for (int i = 0; i < 20; i++) {
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
    max[numero] = int(random(100,140));
    x1[numero] = int(random(0,width-50));
    y[numero] = int(random(0,height-50));
    x[numero] = x1[numero];
  }
  
  for(int w=0; w<20; w++){
    if (activado[w] == 1){
      switch(w){
        
        case 0:
          textSize(s[0]);
          fill(255);
          text("PAZ",x[0],y[0]);
        break;
        
        case 1:
          textSize(s[1]);
          fill(255);
          text("ALEGRIA",x[1],y[1]);
        break;
        
        case 2:
          textSize(s[2]);
          fill(255);
          text("GUERRA",x[2],y[2]);
        break;
        
        case 3:
          textSize(s[3]);
          fill(255);
          text("MUERTE",x[3],y[3]);
        break;
        
        case 4:
          textSize(s[4]);
          fill(255);
          text("VIDA",x[4],y[4]);
        break;
        
        case 5:
          textSize(s[5]);
          fill(255);
          text("LUZ",x[5],y[5]);
        break;
        
        case 6:
          textSize(s[6]);
          fill(255);
          text("OSCURIDAD",x[6],y[6]);
        break;
        
        case 7:
          textSize(s[7]);
          fill(255);
          text("COMPARTIR",x[7],y[7]);
        break;
        
        case 8:
          textSize(s[8]);
          fill(255);
          text("SERVICIO",x[8],y[8]);
        break;
        
        case 9:
          textSize(s[9]);
          fill(255);
          text("COMPROMISO",x[9],y[9]);
        break;
        
        case 10:
          textSize(s[10]);
          fill(255);
          text("INDIFERENCIA",x[10],y[10]);
        break;
        
        case 11:
          textSize(s[11]);
          fill(255);
          text("CRUELDAD",x[11],y[11]);
        break;
        
        case 12:
          textSize(s[12]);
          fill(255);
          text("SUFRIMIENTO",x[12],y[12]);
        break;
        
        case 13:
          textSize(s[13]);
          fill(255);
          text("PLACER",x[13],y[13]);
        break;
        
        case 14:
          textSize(s[14]);
          fill(255);
          text("FELICIDAD",x[14],y[14]);
        break;
        
        case 15:
          textSize(s[15]);
          fill(255);
          text("MOTIVACION",x[15],y[15]);
        break;
        
        case 16:
          textSize(s[16]);
          fill(255);
          text("HONESTIDAD",x[16],y[16]);
        break;
        
        case 17:
          textSize(s[17]);
          fill(255);
          text("MALDAD",x[17],y[17]);
        break;
        
        case 18:
          textSize(s[18]);
          fill(255);
          text("AYUDA",x[18],y[18]);
        break;
        
        case 19:
          textSize(s[19]);
          fill(255);
          text("DESPRECIO",x[19],y[19]);
        break;
      }
    }
  }
  for (int i = 0; i < 20; i++) {
    
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
  if(numero==19){
    numero = 0;
  }
  cuenta++;
  
  
}
