
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int people = 0;
int kinectWidth = 640;
int kinectHeight = 480;
float reScale;
float n = 0.0;

void setup() {
  size(640, 360);
  reScale = (float) width / kinectWidth;
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw() {
  
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  people=int(userList.size());
  println(people);
  
  loadPixels();
  if(n < people){
    n += 0.1;
  }
  float m = n * 1.67;
  //float n = people * 1.67;
  float w = 16.0;         // 2D space width
  float h = 16.0;         // 2D space height
  float dx = w / width;    // Increment x this amount per pixel
  float dy = h / height;   // Increment y this amount per pixel
  float x = -w/2;          // Start x at -1 * width / 2
  for (int i = 0; i < width; i++) {
    float y = -h/2;        // Start y at -1 * height / 2
    for (int j = 0; j < height; j++) {
      float r = sqrt((x*x) + (y*y));    // Convert cartesian to polar
      float theta = atan2(y,x);         // Convert cartesian to polar
      // Compute 2D polar coordinate function
      float val = sin(m*cos(r) + 5 * theta);           // Results in a value between -1 and 1
      //float val = cos(r);                            // Another simple function
      //float val = sin(theta);                        // Another simple function
      // Map resulting vale to grayscale value
      pixels[i+j*width] = color((val + 1.0) * 255.0/2.0);     // Scale to between 0 and 255
      y += dy;                // Increment y
    }
    x += dx;                  // Increment x
  }
  updatePixels();
}
