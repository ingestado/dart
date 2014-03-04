
double visc, diff, vScale, velocityScale;
boolean vectors = false;
int oldMouseX = 1, oldMouseY = 1;
int numCopos;
int c = color(255);
int n;
float cellHeight; 
float cellWidth;
float  limitVelocity;

Copo[] copos; 
Mov mov;

void setup() {
 
  size(600,400, P3D);
  frameRate(150);
 
  n = Mov.N;   //Number of triangles
  cellHeight = height / n;    //Size of each triangle
  cellWidth = width / n;
  
  mov = new Mov();
  numCopos = 400; //(int)pow(2, 16);      //2^16 = 65536 particles
  copos = new Copo[numCopos];
  visc = 0.00025f;
  diff = 0.03f;
  vScale = 3;
  velocityScale = vScale;  //Save the initial triangle scale
  vectors = true;
 
  limitVelocity = 200;
 
  stroke(color(0));
  fill(color(0));
  
  initCopos();
}

void draw() {
 
  handleMouseMotion(); 
  background(0); 
  double dt = 1 / frameRate;
  mov.tick(dt, visc, diff); 
  vScale = velocityScale * 60. / frameRate;
  drawCopos();

}

private void handleMouseMotion() {
  mouseX = max(1, mouseX);      //take highest value, 1 or mouseX.
  mouseY = max(1, mouseY);
 
  float mouseDx = mouseX - oldMouseX;
  float mouseDy = mouseY - oldMouseY;
  int cellX = floor(mouseX / cellWidth);
  int cellY = floor(mouseY / cellHeight);
 
  mov.applyForce(cellX, cellY, mouseDx, mouseDy);
 
  oldMouseX = mouseX;
  oldMouseY = mouseY;
}
