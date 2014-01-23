
float s = 0; //Separación entre hojas de cesped
int total = 400;
int xc = 0;
float[][] coordI = new float [400][2];
float[][] coordF = new float [400][2];
float[][] coordP = new float [400][2];
float[] aleatorio = new float [400];
int[][] x = new int[6][65];
int[][] y = new int[6][65];
int[][] cuentax = new int[6][65];
int[] momento = new int[6];
int[] sx1 = new int[6];
int[] sy1 = new int[6];
int[] sx2 = new int[6];
int[] sy2 = new int[6];
int[] sx3 = new int[6];
int[] sy3 = new int[6];

void setup(){
  size(700,500,P2D);
  background(0); 
  for(int z=0; z<6; z++){
    sx1[z] = 0;
    sy1[z] = 0;
    sx2[z] = 0;
    sy2[z] = 0;
    sx3[z] = 0;
    sy3[z] = 0;
    momento[z] = 0;
    for(int w=0; w<65; w++){
      x[z][w]=0;
      y[z][w]=0;
      cuentax[z][w]=0;
    x[z][0] = width/2;
    x[z][0] = int(random(100,width-100));
    x[z][0] = int(random(100,width-100));
    x[z][0] = int(random(100,width-100));
    x[z][0] = int(random(100,width-100));
    }
   }
   
   s = width/total;
  
  for(int q=0; q<400; q++){
      coordI[q][0] = xc;
      coordI[q][1] = height;
      coordP[q][0] = coordI[q][0];
      coordP[q][1] = coordI[q][1];
      coordF[q][0] = coordI[q][0] + random(-3,3);
      coordF[q][1] = height-15;
      aleatorio[q] = random(-1,+1); 
      xc = xc + 2;
  }
}

void draw(){
  
  for(int q=0; q<400; q++){
      
      fill(255);
      stroke(255);
      line(coordI[q][0],coordI[q][1],coordP[q][0],coordP[q][1]);
     
      if(coordP[q][1] > coordF[q][1]){
        coordP[q][0] = coordP[q][0] + aleatorio[q];
        coordP[q][1]--;
      }
  }
  
  for(int c=0; c<5; c++){
      
    switch (momento[c]){    
         
      case 0:
        sy1[c]++;
        y[c][0] = height;
        x[c][1] = x[c][0] - sx1[c];
        y[c][1] = height - sy1[c];
        
        fill(255);
        stroke(255);
        line(x[c][0],y[c][0],x[c][1],y[c][1]);
        
        if(sy1[c] == 160){
          sx1[c] = 0;
          sy1[c] = 0;
          momento[c]=1;
        }
      break;
      
      case 1:
        line(x[c][0],y[c][0],x[c][1],y[c][1]);
        sy1[c]++;
        if(cuentax[c][0] > 1){
          sx1[c]++;
          cuentax[c][0] = 0;
        }      
        x[c][2] = x[c][1] - sx1[c];
        y[c][2] = y[c][1] - sy1[c];
        x[c][3] = x[c][1] + sx1[c];
        y[c][3] = y[c][1] - sy1[c];
        fill(255);
        stroke(255);
        line(x[c][1],y[c][1],x[c][3],y[c][3]);
        line(x[c][1],y[c][1],x[c][2],y[c][2]);
        
        if(sy1[c] == 100){
          sx1[c] = 0;
          sy1[c] = 0;
          momento[c]++;
        }
      break;
      
      case 2:
        line(x[c][0],y[c][0],x[c][1],y[c][1]);
        line(x[c][1],y[c][1],x[c][3],y[c][3]);
        line(x[c][1],y[c][1],x[c][2],y[c][2]);
        
        sy1[c]++;
        sx2[c]++;
        sy2[c]++;
        if(cuentax[c][0] > 2){
          sx1[c]++;
          cuentax[c][0] = 0;
        }   
        x[c][5] = x[c][3] + sx1[c];
        y[c][5] = y[c][3] - sy1[c];
        x[c][4] = x[c][3] + sx2[c];
        y[c][4] = y[c][3] - sy2[c];
        x[c][6] = x[c][2] - sx1[c];
        y[c][6] = y[c][2] - sy1[c];
        x[c][7] = x[c][2] - sx2[c];
        y[c][7] = y[c][2] - sy2[c];
        fill(255);
        stroke(255);
        line(x[c][3],y[c][3],x[c][4],y[c][4]);
        line(x[c][3],y[c][3],x[c][5],y[c][5]);
        line(x[c][2],y[c][2],x[c][6],y[c][6]);
        line(x[c][2],y[c][2],x[c][7],y[c][7]);
        
        if(sy1[c] == 80){
          sx1[c] = 0;
          sy1[c] = 0;
          sx2[c] = 0;
          sy2[c] = 0;
          momento[c]++;
        }
      break;
      
      case 3:
        line(x[c][0],y[c][0],x[c][1],y[c][1]);
        line(x[c][1],y[c][1],x[c][3],y[c][3]);
        line(x[c][1],y[c][1],x[c][2],y[c][2]);
        line(x[c][3],y[c][3],x[c][4],y[c][4]);
        line(x[c][3],y[c][3],x[c][5],y[c][5]);
        line(x[c][2],y[c][2],x[c][6],y[c][6]);
        line(x[c][2],y[c][2],x[c][7],y[c][7]);
        
        sy1[c]++;
        if(cuentax[c][0] < 60){
          sx1[c]++;
        }
        if (cuentax[c][1] > 1){
          sy2[c]++;
          cuentax[c][1] = 0;
        }  
        if (cuentax[c][2] > 2){
          sx2[c]++;
          cuentax[c][2] = 0;
        } 
        sy3[c]++;
        if(cuentax[c][3] > 1){
          sx3[c]++;
          cuentax[c][3] = 0;
        }
        x[c][8] = x[c][4] + sx1[c];
        y[c][8] = y[c][4];
        x[c][9] = x[c][4] + sx2[c];
        y[c][9] = y[c][4] - sy2[c];
        x[c][10] = x[c][5] + sx3[c];
        y[c][10] = y[c][5] - sy3[c];
        x[c][11] = x[c][5] - sx3[c];
        y[c][11] = y[c][5] - sy3[c];
        x[c][12] = x[c][6] + sx3[c];
        y[c][12] = y[c][6] - sy3[c];
        x[c][13] = x[c][6] - sx3[c];
        y[c][13] = y[c][6] - sy3[c];
        x[c][14] = x[c][7] - sx2[c];
        y[c][14] = y[c][7] - sy2[c];
        x[c][15] = x[c][7] - sx1[c];
        y[c][15] = y[c][7];
        
        fill(255);
        stroke(255);
        line(x[c][4],y[c][4],x[c][8],y[c][8]);
        line(x[c][4],y[c][4],x[c][9],y[c][9]);
        line(x[c][5],y[c][5],x[c][10],y[c][10]);
        line(x[c][5],y[c][5],x[c][11],y[c][11]);
        line(x[c][6],y[c][6],x[c][12],y[c][12]);
        line(x[c][6],y[c][6],x[c][13],y[c][13]);
        line(x[c][7],y[c][7],x[c][14],y[c][14]);
        line(x[c][7],y[c][7],x[c][15],y[c][15]);
  
        
        if(sy1[c] == 70){
          sx1[c] = 0;
          sy1[c] = 0;
          sx2[c] = 0;
          sy2[c] = 0;
          sx3[c] = 0;
          sy3[c] = 0;
          cuentax[c][0] = 0;
          momento[c]++;
        }
      break;
      
      case 4:
        line(x[c][0],y[c][0],x[c][1],y[c][1]);
        line(x[c][1],y[c][1],x[c][3],y[c][3]);
        line(x[c][1],y[c][1],x[c][2],y[c][2]);
        line(x[c][3],y[c][3],x[c][4],y[c][4]);
        line(x[c][3],y[c][3],x[c][5],y[c][5]);
        line(x[c][2],y[c][2],x[c][6],y[c][6]);
        line(x[c][2],y[c][2],x[c][7],y[c][7]);
        line(x[c][4],y[c][4],x[c][8],y[c][8]);
        line(x[c][4],y[c][4],x[c][9],y[c][9]);
        line(x[c][5],y[c][5],x[c][10],y[c][10]);
        line(x[c][5],y[c][5],x[c][11],y[c][11]);
        line(x[c][6],y[c][6],x[c][12],y[c][12]);
        line(x[c][6],y[c][6],x[c][13],y[c][13]);
        line(x[c][7],y[c][7],x[c][14],y[c][14]);
        line(x[c][7],y[c][7],x[c][15],y[c][15]);
        
        sy1[c]++;
        if(cuentax[c][0] < 30){
          sx1[c]++;
        }
        if (cuentax[c][1] > 1){
          sy2[c]++;
          cuentax[c][1] = 0;
        }  
        if (cuentax[c][2] > 1){
          sx2[c]++;
          cuentax[c][2] = 0;
        } 
        sy3[c]++;
        if(cuentax[c][3] > 1){
          sx3[c]++;
          cuentax[c][3] = 0;
        }
        x[c][16] = x[c][8] + sx2[c];
        y[c][16] = y[c][8] + sy2[c];
        x[c][17] = x[c][8] + sx2[c];
        y[c][17] = y[c][8] - sy2[c];
        x[c][18] = x[c][9] + sx1[c];
        y[c][18] = y[c][9];
        x[c][19] = x[c][9] + sx2[c];
        y[c][19] = y[c][9] - sy2[c];
        x[c][20] = x[c][10] + sx3[c];
        y[c][20] = y[c][10] - sy3[c];
        x[c][21] = x[c][10] - sx3[c];
        y[c][21] = y[c][10] - sy3[c];
        x[c][22] = x[c][11] + sx3[c];
        y[c][22] = y[c][11] - sy3[c];
        x[c][23] = x[c][11] - sx3[c];
        y[c][23] = y[c][11] - sx3[c];
        x[c][24] = x[c][12] + sx3[c];
        y[c][24] = y[c][12] - sx3[c];
        x[c][25] = x[c][12] - sx3[c];
        y[c][25] = y[c][12] - sy3[c];
        x[c][26] = x[c][13] + sx3[c];
        y[c][26] = y[c][13] - sy3[c];
        x[c][27] = x[c][13] - sx3[c];
        y[c][27] = y[c][13] - sy3[c];
        x[c][28] = x[c][14] - sx3[c];
        y[c][28] = y[c][14] - sy3[c];
        x[c][29] = x[c][14] - sx1[c];
        y[c][29] = y[c][14];
        x[c][30] = x[c][15] - sx2[c];
        y[c][30] = y[c][15] - sy2[c];
        x[c][31] = x[c][15] - sx2[c];
        y[c][31] = y[c][15] + sy2[c];
        
        fill(255);
        stroke(255);
        
        line(x[c][8],y[c][8],x[c][16],y[c][16]);
        line(x[c][8],y[c][8],x[c][17],y[c][17]);
        line(x[c][9],y[c][9],x[c][18],y[c][18]);
        line(x[c][9],y[c][9],x[c][19],y[c][19]);
        line(x[c][10],y[c][10],x[c][20],y[c][20]);
        line(x[c][10],y[c][10],x[c][21],y[c][21]);
        line(x[c][11],y[c][11],x[c][22],y[c][22]);
        line(x[c][11],y[c][11],x[c][23],y[c][23]);
        line(x[c][12],y[c][12],x[c][24],y[c][24]);
        line(x[c][12],y[c][12],x[c][25],y[c][25]);
        line(x[c][13],y[c][13],x[c][26],y[c][26]);
        line(x[c][13],y[c][13],x[c][27],y[c][27]);
        line(x[c][14],y[c][14],x[c][28],y[c][28]);
        line(x[c][14],y[c][14],x[c][29],y[c][29]);
        line(x[c][15],y[c][15],x[c][30],y[c][30]);
        line(x[c][15],y[c][15],x[c][31],y[c][31]);
  
        
        if(sy1[c] == 40){
          sx1[c] = 0;
          sy1[c] = 0;
          sx2[c] = 0;
          sy2[c] = 0;
          sx3[c] = 0;
          sy3[c] = 0;
          cuentax[c][0] = 0;
          momento[c]++;
        }
      break;
      
      case 5:
        line(x[c][0],y[c][0],x[c][1],y[c][1]);
        line(x[c][1],y[c][1],x[c][3],y[c][3]);
        line(x[c][1],y[c][1],x[c][2],y[c][2]);
        line(x[c][3],y[c][3],x[c][4],y[c][4]);
        line(x[c][3],y[c][3],x[c][5],y[c][5]);
        line(x[c][2],y[c][2],x[c][6],y[c][6]);
        line(x[c][2],y[c][2],x[c][7],y[c][7]);
        line(x[c][4],y[c][4],x[c][8],y[c][8]);
        line(x[c][4],y[c][4],x[c][9],y[c][9]);
        line(x[c][5],y[c][5],x[c][10],y[c][10]);
        line(x[c][5],y[c][5],x[c][11],y[c][11]);
        line(x[c][6],y[c][6],x[c][12],y[c][12]);
        line(x[c][6],y[c][6],x[c][13],y[c][13]);
        line(x[c][7],y[c][7],x[c][14],y[c][14]);
        line(x[c][7],y[c][7],x[c][15],y[c][15]);
        line(x[c][8],y[c][8],x[c][16],y[c][16]);
        line(x[c][8],y[c][8],x[c][17],y[c][17]);
        line(x[c][9],y[c][9],x[c][18],y[c][18]);
        line(x[c][9],y[c][9],x[c][19],y[c][19]);
        line(x[c][10],y[c][10],x[c][20],y[c][20]);
        line(x[c][10],y[c][10],x[c][21],y[c][21]);
        line(x[c][11],y[c][11],x[c][22],y[c][22]);
        line(x[c][11],y[c][11],x[c][23],y[c][23]);
        line(x[c][12],y[c][12],x[c][24],y[c][24]);
        line(x[c][12],y[c][12],x[c][25],y[c][25]);
        line(x[c][13],y[c][13],x[c][26],y[c][26]);
        line(x[c][13],y[c][13],x[c][27],y[c][27]);
        line(x[c][14],y[c][14],x[c][28],y[c][28]);
        line(x[c][14],y[c][14],x[c][29],y[c][29]);
        line(x[c][15],y[c][15],x[c][30],y[c][30]);
        line(x[c][15],y[c][15],x[c][31],y[c][31]);
        
        sy1[c]++;
        if(cuentax[c][0] < 60){
          sx1[c]++;
        }
        if (cuentax[c][1] > 1){
          sy2[c]++;
          cuentax[c][1] = 0;
        }  
        if (cuentax[c][2] > 1){
          sx2[c]++;
          cuentax[c][2] = 0;
        } 
        sy3[c]++;
        if(cuentax[c][3] > 1){
          sx3[c]++;
          cuentax[c][3] = 0;
        }
        x[c][32] = x[c][16] + sx2[c];
        y[c][32] = y[c][16] + sy2[c];
        x[c][33] = x[c][16] + sx2[c];
        y[c][33] = y[c][16] - sy2[c];
        x[c][34] = x[c][17] + sx2[c];
        y[c][34] = y[c][17] + sy2[c];
        x[c][35] = x[c][17] + sx2[c];
        y[c][35] = y[c][17] - sy2[c];
        x[c][36] = x[c][18] + sx1[c];
        y[c][36] = y[c][18];
        x[c][37] = x[c][18] + sx2[c];
        y[c][37] = y[c][18] - sy2[c];
        x[c][38] = x[c][19] + sx1[c];
        y[c][38] = y[c][19];
        x[c][39] = x[c][19] + sx2[c];
        y[c][39] = y[c][19] - sx2[c];
        x[c][40] = x[c][20] + sx3[c];
        y[c][40] = y[c][20] - sx3[c];
        x[c][41] = x[c][20] - sx3[c];
        y[c][41] = y[c][20] - sy3[c];
        x[c][42] = x[c][21] + sx3[c];
        y[c][42] = y[c][21] - sy3[c];
        x[c][43] = x[c][21] - sx3[c];
        y[c][43] = y[c][21] - sy3[c];
        x[c][44] = x[c][22] + sx3[c];
        y[c][44] = y[c][22] - sy3[c];
        x[c][45] = x[c][22] - sx3[c];
        y[c][45] = y[c][22] - sy3[c];
        x[c][46] = x[c][23] + sx3[c];
        y[c][46] = y[c][23] - sy3[c];
        x[c][47] = x[c][23] - sx3[c];
        y[c][47] = y[c][23] - sy3[c];
        x[c][48] = x[c][24] + sx3[c];
        y[c][48] = y[c][24] - sy3[c];
        x[c][49] = x[c][24] - sx3[c];
        y[c][49] = y[c][24] - sy3[c];
        x[c][50] = x[c][25] + sx3[c];
        y[c][50] = y[c][25] - sy3[c];
        x[c][51] = x[c][25] - sx3[c];
        y[c][51] = y[c][25] - sy3[c];
        x[c][52] = x[c][26] + sx3[c];
        y[c][52] = y[c][26] - sy3[c];
        x[c][53] = x[c][26] - sx3[c];
        y[c][53] = y[c][26] - sy3[c];
        x[c][54] = x[c][27] + sx3[c];
        y[c][54] = y[c][27] - sy3[c];
        x[c][55] = x[c][27] - sx3[c];
        y[c][55] = y[c][27] - sx3[c];
        x[c][56] = x[c][28] - sx3[c];
        y[c][56] = y[c][28] - sx3[c];
        x[c][57] = x[c][28] - sx1[c];
        y[c][57] = y[c][28];
        x[c][58] = x[c][29] - sx3[c];
        y[c][58] = y[c][29] - sy3[c];
        x[c][59] = x[c][29] - sx1[c];
        y[c][59] = y[c][29];
        x[c][60] = x[c][30] - sx2[c];
        y[c][60] = y[c][30] - sy2[c];
        x[c][61] = x[c][30] - sx2[c];
        y[c][61] = y[c][30] + sy2[c];
        x[c][62] = x[c][31] - sx2[c];
        y[c][62] = y[c][31] - sy2[c];
        x[c][63] = x[c][31] - sx2[c];
        y[c][63] = y[c][31] + sy2[c];
        
        fill(255);
        stroke(255);
        
        line(x[c][16],y[c][16],x[c][32],y[c][32]);
        line(x[c][16],y[c][16],x[c][33],y[c][33]);
        line(x[c][17],y[c][17],x[c][34],y[c][34]);
        line(x[c][17],y[c][17],x[c][35],y[c][35]);
        line(x[c][18],y[c][18],x[c][36],y[c][36]);
        line(x[c][18],y[c][18],x[c][37],y[c][37]);
        line(x[c][19],y[c][19],x[c][38],y[c][38]);
        line(x[c][19],y[c][19],x[c][39],y[c][39]);
        line(x[c][20],y[c][20],x[c][40],y[c][40]);
        line(x[c][20],y[c][20],x[c][41],y[c][41]);
        line(x[c][21],y[c][21],x[c][42],y[c][42]);
        line(x[c][21],y[c][21],x[c][43],y[c][43]);
        line(x[c][22],y[c][22],x[c][44],y[c][44]);
        line(x[c][22],y[c][22],x[c][45],y[c][45]);
        line(x[c][23],y[c][23],x[c][46],y[c][46]);
        line(x[c][23],y[c][23],x[c][47],y[c][47]);
        line(x[c][24],y[c][24],x[c][48],y[c][48]);
        line(x[c][24],y[c][24],x[c][49],y[c][49]);
        line(x[c][25],y[c][25],x[c][50],y[c][50]);
        line(x[c][25],y[c][25],x[c][51],y[c][51]);
        line(x[c][26],y[c][26],x[c][52],y[c][52]);
        line(x[c][26],y[c][26],x[c][53],y[c][53]);
        line(x[c][27],y[c][27],x[c][54],y[c][54]);
        line(x[c][27],y[c][27],x[c][55],y[c][55]);
        line(x[c][28],y[c][28],x[c][56],y[c][56]);
        line(x[c][28],y[c][28],x[c][57],y[c][57]);
        line(x[c][29],y[c][29],x[c][58],y[c][58]);
        line(x[c][29],y[c][29],x[c][59],y[c][59]);
        line(x[c][30],y[c][30],x[c][60],y[c][60]);
        line(x[c][30],y[c][30],x[c][61],y[c][61]);
        line(x[c][31],y[c][31],x[c][62],y[c][62]);
        line(x[c][31],y[c][31],x[c][63],y[c][63]);
        
        if(sy1[c] == 20){
          sx1[c] = 0;
          sy1[c] = 0;
          sx2[c] = 0;
          sy2[c] = 0;
          sx3[c] = 0;
          sy3[c] = 0;
          cuentax[c][0] = 0;
          momento[c]++;
        }
      break;
      
    }
    for(int u=0; u<20; u++){
      cuentax[c][u]++;
    }
  }
}
