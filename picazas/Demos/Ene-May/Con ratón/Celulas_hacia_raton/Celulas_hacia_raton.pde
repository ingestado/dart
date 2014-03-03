int MAX=200;
// declare array of positions
float[] myxlocs = new float[MAX];  //X position
float[] myylocs = new float[MAX];  //Y position

Ring1[] myRings1 = new Ring1[MAX];


void setup() {
  size(500,500);
  // fill array with locations
  for(int i=0; i<MAX; i++) {
    myxlocs[i]=random(width);
    myylocs[i]=random(height);
  }

  for (int i = 0; i < MAX; i++) { 
    float tempxp = random(2*width);
    float tempyp = random(2*height);
    float tempxv = random(1,1.5);
    float tempyv = random(1,1.5);
    myRings1[i] = new Ring1(tempxp, tempyp, tempxv, tempyv);

  }
  smooth();
} 

void draw() {
  background(255);
  
  for (int i=0; i<MAX; i++) {
    myRings1[i].changeVel();
    myRings1[i].drive();
    myRings1[i].draw();
  }
  
  if(mousePressed==true){
    println(mouseX+" . "+mouseY);
  }
}




