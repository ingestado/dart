
double visc, diff, vScale, velocityScale;
boolean vectors = false;
int oldMouseX = 1, oldMouseY = 1;
int numParticles;
int c = color(255);
int n;
float cellHeight; 
float cellWidth;
float  limitVelocity;

Particle[] particles; 
Mov mov;

void setup() {
 
  size(600,400, P2D);
  frameRate(150);
 
  n = Mov.N;   //Number of triangles
  cellHeight = height / n;    //Size of each triangle
  cellWidth = width / n;
  
  mov = new Mov();
  numParticles = (int)pow(2, 16);      //2^16 = 65536 particles
  particles = new Particle[numParticles];
  visc = 0.00025f;
  diff = 0.03f;
  vScale = 3;
  velocityScale = vScale;  //Save the initial triangle scale
  vectors = true;
 
  limitVelocity = 200;
 
  stroke(color(0));
  fill(color(0));
  
  initParticles();
}

void draw() {
 
  handleMouseMotion(); 
  background(0); 
  double dt = 1 / frameRate;
  mov.tick(dt, visc, diff); 
  vScale = velocityScale * 60. / frameRate;
  drawParticlesPixels();

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
