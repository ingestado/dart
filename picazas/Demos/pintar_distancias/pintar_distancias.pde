import SimpleOpenNI.*;
SimpleOpenNI kinect;

int posicion;
int clickedDepth;
float milimetros;

void setup(){
  size (640,480);
  kinect=new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw(){
  kinect.update();
  int[] depthValues = kinect.depthMap();
  for(int x = 0; x < 640; x++){
    for(int y = 0; y < 480; y++){
      posicion = x + (y*640);
      clickedDepth = depthValues[posicion];
      milimetros = clickedDepth;
      if (milimetros < 1000){
        fill(255,0,0);
        ellipse (x,y,0.5,0.5);}
      else if (milimetros < 2000){
        fill(0,255,0);
        ellipse (x,y,0.5,0.5);}
      else if (milimetros > 2000) {
        fill(0,0,255);
        ellipse (x,y,0.5,0.5);}
    }
  }
  PImage depthImage = kinect.depthImage();
  image(depthImage,0,0);
}

void mousePressed (){
  int[] depthValues = kinect.depthMap();
  int clickPosition = mouseX + (mouseY*640);
  int clickedDepth = depthValues[clickPosition];
  float inches = clickedDepth / 25.4;
  float milimetros = clickedDepth;
  inches = inches * 0.025400;
  println("metros: " + inches + "milimetros:" + milimetros);
}
