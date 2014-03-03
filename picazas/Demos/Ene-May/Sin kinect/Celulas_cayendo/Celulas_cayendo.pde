int MAX=100;
// declare array of positions
float[] myxlocs = new float[MAX];
float[] myylocs = new float[MAX];

Ring1[] myRings1 = new Ring1[MAX];
Ring2[] myRings2 = new Ring2[MAX];
Ring3[] myRings3 = new Ring3[MAX];

void setup() {
  size(500,500);
  // fill array with locations
  for(int i=0; i<MAX; i++) {
    myxlocs[i]=random(width);
    myylocs[i]=random(height);
  }

  for (int i = 0; i < MAX; i++) { 
    float tempxp = random(width);
    float tempyp = random(height);
    float tempxv = random(1,1.5);
    float tempyv = random(1,1.5);
    myRings1[i] = new Ring1(tempxp, tempyp, tempxv, tempyv);
    myRings2[i] = new Ring2(tempxp, tempyp, tempxv, tempyv);
    myRings3[i] = new Ring3(tempxp, tempyp, tempxv, tempyv);
  }
  smooth();
} 

void draw() {
  background(255);
  
  for (int i=0; i<MAX; i++) {
    myRings3[i].drive();
    myRings3[i].draw();
  }
  
  for (int i=0; i<MAX; i++) {
    myRings2[i].drive();
    myRings2[i].draw();
  }
  
  for (int i=0; i<MAX; i++) {
    myRings1[i].drive();
    myRings1[i].draw();
  }
}




