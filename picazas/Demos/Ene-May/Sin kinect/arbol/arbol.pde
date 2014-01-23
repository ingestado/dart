
int momento = 0;
int[] x = new int[65];
int[] y = new int[65];
int sx1 = 0;
int sy1 = 0;
int sx2 = 0;
int sy2 = 0;
int sx3 = 0;
int sy3 = 0;
int[] cuentax = new int[65];

void setup(){
  size(700,500,P2D);
  background(0); 
  for( int w=0; w<65; w++){
    x[w]=0;
    y[w]=0;
    cuentax[w]=0;
  }
}

void draw(){
  
  switch (momento){
  
    case 0:
      sy1++;
      x[0] = width/2;
      y[0] = height;
      x[1] = width/2 - sx1;
      y[1] = height - sy1;
      
      fill(255);
      stroke(255);
      line(x[0],y[0],x[1],y[1]);
      
      if(sy1 == 160){
        sx1 = 0;
        sy1 = 0;
        momento=1;
      }
    break;
    
    case 1:
      line(x[0],y[0],x[1],y[1]);
      sy1++;
      if(cuentax[0] > 1){
        sx1++;
        cuentax[0] = 0;
      }      
      x[2] = x[1] - sx1;
      y[2] = y[1] - sy1;
      x[3] = x[1] + sx1;
      y[3] = y[1] - sy1;
      fill(255);
      stroke(255);
      line(x[1],y[1],x[3],y[3]);
      line(x[1],y[1],x[2],y[2]);
      
      if(sy1 == 100){
        sx1 = 0;
        sy1 = 0;
        momento++;
      }
    break;
    
    case 2:
      line(x[0],y[0],x[1],y[1]);
      line(x[1],y[1],x[3],y[3]);
      line(x[1],y[1],x[2],y[2]);
      
      sy1++;
      sx2++;
      sy2++;
      if(cuentax[0] > 2){
        sx1++;
        cuentax[0] = 0;
      }   
      x[5] = x[3] + sx1;
      y[5] = y[3] - sy1;
      x[4] = x[3] + sx2;
      y[4] = y[3] - sy2;
      x[6] = x[2] - sx1;
      y[6] = y[2] - sy1;
      x[7] = x[2] - sx2;
      y[7] = y[2] - sy2;
      fill(255);
      stroke(255);
      line(x[3],y[3],x[4],y[4]);
      line(x[3],y[3],x[5],y[5]);
      line(x[2],y[2],x[6],y[6]);
      line(x[2],y[2],x[7],y[7]);
      
      if(sy1 == 80){
        sx1 = 0;
        sy1 = 0;
        sx2 = 0;
        sy2 = 0;
        momento++;
      }
    break;
    
    case 3:
      line(x[0],y[0],x[1],y[1]);
      line(x[1],y[1],x[3],y[3]);
      line(x[1],y[1],x[2],y[2]);
      line(x[3],y[3],x[4],y[4]);
      line(x[3],y[3],x[5],y[5]);
      line(x[2],y[2],x[6],y[6]);
      line(x[2],y[2],x[7],y[7]);
      
      sy1++;
      if(cuentax[0] < 60){
        sx1++;
      }
      if (cuentax[1] > 1){
        sy2++;
        cuentax[1] = 0;
      }  
      if (cuentax[2] > 2){
        sx2++;
        cuentax[2] = 0;
      } 
      sy3++;
      if(cuentax[3] > 1){
        sx3++;
        cuentax[3] = 0;
      }
      x[8] = x[4] + sx1;
      y[8] = y[4];
      x[9] = x[4] + sx2;
      y[9] = y[4] - sy2;
      x[10] = x[5] + sx3;
      y[10] = y[5] - sy3;
      x[11] = x[5] - sx3;
      y[11] = y[5] - sy3;
      x[12] = x[6] + sx3;
      y[12] = y[6] - sy3;
      x[13] = x[6] - sx3;
      y[13] = y[6] - sy3;
      x[14] = x[7] - sx2;
      y[14] = y[7] - sy2;
      x[15] = x[7] - sx1;
      y[15] = y[7];
      
      fill(255);
      stroke(255);
      line(x[4],y[4],x[8],y[8]);
      line(x[4],y[4],x[9],y[9]);
      line(x[5],y[5],x[10],y[10]);
      line(x[5],y[5],x[11],y[11]);
      line(x[6],y[6],x[12],y[12]);
      line(x[6],y[6],x[13],y[13]);
      line(x[7],y[7],x[14],y[14]);
      line(x[7],y[7],x[15],y[15]);

      
      if(sy1 == 70){
        sx1 = 0;
        sy1 = 0;
        sx2 = 0;
        sy2 = 0;
        sx3 = 0;
        sy3 = 0;
        cuentax[0] = 0;
        momento++;
      }
    break;
    
    case 4:
      line(x[0],y[0],x[1],y[1]);
      line(x[1],y[1],x[3],y[3]);
      line(x[1],y[1],x[2],y[2]);
      line(x[3],y[3],x[4],y[4]);
      line(x[3],y[3],x[5],y[5]);
      line(x[2],y[2],x[6],y[6]);
      line(x[2],y[2],x[7],y[7]);
      line(x[4],y[4],x[8],y[8]);
      line(x[4],y[4],x[9],y[9]);
      line(x[5],y[5],x[10],y[10]);
      line(x[5],y[5],x[11],y[11]);
      line(x[6],y[6],x[12],y[12]);
      line(x[6],y[6],x[13],y[13]);
      line(x[7],y[7],x[14],y[14]);
      line(x[7],y[7],x[15],y[15]);
      
      sy1++;
      if(cuentax[0] < 30){
        sx1++;
      }
      if (cuentax[1] > 1){
        sy2++;
        cuentax[1] = 0;
      }  
      if (cuentax[2] > 1){
        sx2++;
        cuentax[2] = 0;
      } 
      sy3++;
      if(cuentax[3] > 1){
        sx3++;
        cuentax[3] = 0;
      }
      x[16] = x[8] + sx2;
      y[16] = y[8] + sy2;
      x[17] = x[8] + sx2;
      y[17] = y[8] - sy2;
      x[18] = x[9] + sx1;
      y[18] = y[9];
      x[19] = x[9] + sx2;
      y[19] = y[9] - sy2;
      x[20] = x[10] + sx3;
      y[20] = y[10] - sy3;
      x[21] = x[10] - sx3;
      y[21] = y[10] - sy3;
      x[22] = x[11] + sx3;
      y[22] = y[11] - sy3;
      x[23] = x[11] - sx3;
      y[23] = y[11] - sx3;
      x[24] = x[12] + sx3;
      y[24] = y[12] - sx3;
      x[25] = x[12] - sx3;
      y[25] = y[12] - sy3;
      x[26] = x[13] + sx3;
      y[26] = y[13] - sy3;
      x[27] = x[13] - sx3;
      y[27] = y[13] - sy3;
      x[28] = x[14] - sx3;
      y[28] = y[14] - sy3;
      x[29] = x[14] - sx1;
      y[29] = y[14];
      x[30] = x[15] - sx2;
      y[30] = y[15] - sy2;
      x[31] = x[15] - sx2;
      y[31] = y[15] + sy2;
      
      fill(255);
      stroke(255);
      
      line(x[8],y[8],x[16],y[16]);
      line(x[8],y[8],x[17],y[17]);
      line(x[9],y[9],x[18],y[18]);
      line(x[9],y[9],x[19],y[19]);
      line(x[10],y[10],x[20],y[20]);
      line(x[10],y[10],x[21],y[21]);
      line(x[11],y[11],x[22],y[22]);
      line(x[11],y[11],x[23],y[23]);
      line(x[12],y[12],x[24],y[24]);
      line(x[12],y[12],x[25],y[25]);
      line(x[13],y[13],x[26],y[26]);
      line(x[13],y[13],x[27],y[27]);
      line(x[14],y[14],x[28],y[28]);
      line(x[14],y[14],x[29],y[29]);
      line(x[15],y[15],x[30],y[30]);
      line(x[15],y[15],x[31],y[31]);

      
      if(sy1 == 40){
        sx1 = 0;
        sy1 = 0;
        sx2 = 0;
        sy2 = 0;
        sx3 = 0;
        sy3 = 0;
        cuentax[0] = 0;
        momento++;
      }
    break;
    
    case 5:
      line(x[0],y[0],x[1],y[1]);
      line(x[1],y[1],x[3],y[3]);
      line(x[1],y[1],x[2],y[2]);
      line(x[3],y[3],x[4],y[4]);
      line(x[3],y[3],x[5],y[5]);
      line(x[2],y[2],x[6],y[6]);
      line(x[2],y[2],x[7],y[7]);
      line(x[4],y[4],x[8],y[8]);
      line(x[4],y[4],x[9],y[9]);
      line(x[5],y[5],x[10],y[10]);
      line(x[5],y[5],x[11],y[11]);
      line(x[6],y[6],x[12],y[12]);
      line(x[6],y[6],x[13],y[13]);
      line(x[7],y[7],x[14],y[14]);
      line(x[7],y[7],x[15],y[15]);
      line(x[8],y[8],x[16],y[16]);
      line(x[8],y[8],x[17],y[17]);
      line(x[9],y[9],x[18],y[18]);
      line(x[9],y[9],x[19],y[19]);
      line(x[10],y[10],x[20],y[20]);
      line(x[10],y[10],x[21],y[21]);
      line(x[11],y[11],x[22],y[22]);
      line(x[11],y[11],x[23],y[23]);
      line(x[12],y[12],x[24],y[24]);
      line(x[12],y[12],x[25],y[25]);
      line(x[13],y[13],x[26],y[26]);
      line(x[13],y[13],x[27],y[27]);
      line(x[14],y[14],x[28],y[28]);
      line(x[14],y[14],x[29],y[29]);
      line(x[15],y[15],x[30],y[30]);
      line(x[15],y[15],x[31],y[31]);
      
      sy1++;
      if(cuentax[0] < 60){
        sx1++;
      }
      if (cuentax[1] > 1){
        sy2++;
        cuentax[1] = 0;
      }  
      if (cuentax[2] > 1){
        sx2++;
        cuentax[2] = 0;
      } 
      sy3++;
      if(cuentax[3] > 1){
        sx3++;
        cuentax[3] = 0;
      }
      x[32] = x[16] + sx2;
      y[32] = y[16] + sy2;
      x[33] = x[16] + sx2;
      y[33] = y[16] - sy2;
      x[34] = x[17] + sx2;
      y[34] = y[17] + sy2;
      x[35] = x[17] + sx2;
      y[35] = y[17] - sy2;
      x[36] = x[18] + sx1;
      y[36] = y[18];
      x[37] = x[18] + sx2;
      y[37] = y[18] - sy2;
      x[38] = x[19] + sx1;
      y[38] = y[19];
      x[39] = x[19] + sx2;
      y[39] = y[19] - sx2;
      x[40] = x[20] + sx3;
      y[40] = y[20] - sx3;
      x[41] = x[20] - sx3;
      y[41] = y[20] - sy3;
      x[42] = x[21] + sx3;
      y[42] = y[21] - sy3;
      x[43] = x[21] - sx3;
      y[43] = y[21] - sy3;
      x[44] = x[22] + sx3;
      y[44] = y[22] - sy3;
      x[45] = x[22] - sx3;
      y[45] = y[22] - sy3;
      x[46] = x[23] + sx3;
      y[46] = y[23] - sy3;
      x[47] = x[23] - sx3;
      y[47] = y[23] - sy3;
      x[48] = x[24] + sx3;
      y[48] = y[24] - sy3;
      x[49] = x[24] - sx3;
      y[49] = y[24] - sy3;
      x[50] = x[25] + sx3;
      y[50] = y[25] - sy3;
      x[51] = x[25] - sx3;
      y[51] = y[25] - sy3;
      x[52] = x[26] + sx3;
      y[52] = y[26] - sy3;
      x[53] = x[26] - sx3;
      y[53] = y[26] - sy3;
      x[54] = x[27] + sx3;
      y[54] = y[27] - sy3;
      x[55] = x[27] - sx3;
      y[55] = y[27] - sx3;
      x[56] = x[28] - sx3;
      y[56] = y[28] - sx3;
      x[57] = x[28] - sx1;
      y[57] = y[28];
      x[58] = x[29] - sx3;
      y[58] = y[29] - sy3;
      x[59] = x[29] - sx1;
      y[59] = y[29];
      x[60] = x[30] - sx2;
      y[60] = y[30] - sy2;
      x[61] = x[30] - sx2;
      y[61] = y[30] + sy2;
      x[62] = x[31] - sx2;
      y[62] = y[31] - sy2;
      x[63] = x[31] - sx2;
      y[63] = y[31] + sy2;
      
      fill(255);
      stroke(255);
      
      line(x[16],y[16],x[32],y[32]);
      line(x[16],y[16],x[33],y[33]);
      line(x[17],y[17],x[34],y[34]);
      line(x[17],y[17],x[35],y[35]);
      line(x[18],y[18],x[36],y[36]);
      line(x[18],y[18],x[37],y[37]);
      line(x[19],y[19],x[38],y[38]);
      line(x[19],y[19],x[39],y[39]);
      line(x[20],y[20],x[40],y[40]);
      line(x[20],y[20],x[41],y[41]);
      line(x[21],y[21],x[42],y[42]);
      line(x[21],y[21],x[43],y[43]);
      line(x[22],y[22],x[44],y[44]);
      line(x[22],y[22],x[45],y[45]);
      line(x[23],y[23],x[46],y[46]);
      line(x[23],y[23],x[47],y[47]);
      line(x[24],y[24],x[48],y[48]);
      line(x[24],y[24],x[49],y[49]);
      line(x[25],y[25],x[50],y[50]);
      line(x[25],y[25],x[51],y[51]);
      line(x[26],y[26],x[52],y[52]);
      line(x[26],y[26],x[53],y[53]);
      line(x[27],y[27],x[54],y[54]);
      line(x[27],y[27],x[55],y[55]);
      line(x[28],y[28],x[56],y[56]);
      line(x[28],y[28],x[57],y[57]);
      line(x[29],y[29],x[58],y[58]);
      line(x[29],y[29],x[59],y[59]);
      line(x[30],y[30],x[60],y[60]);
      line(x[30],y[30],x[61],y[61]);
      line(x[31],y[31],x[62],y[62]);
      line(x[31],y[31],x[63],y[63]);
      
      if(sy1 == 20){
        sx1 = 0;
        sy1 = 0;
        sx2 = 0;
        sy2 = 0;
        sx3 = 0;
        sy3 = 0;
        cuentax[0] = 0;
        momento++;
      }
    break;
    
    
    
  }
  println("Momento: " + momento);
  println("X2: " + sx2);
  println("X1: " + sy2);
  println("Cuenta: " + cuentax[1]);
  for(int u=0; u<20; u++){
    cuentax[u]++;
  }
}
