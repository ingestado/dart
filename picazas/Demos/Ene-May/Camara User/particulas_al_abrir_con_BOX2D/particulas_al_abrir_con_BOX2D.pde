
import SimpleOpenNI.*;
SimpleOpenNI kinect;
import processing.opengl.*;
import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
PBox2D box2d;
ArrayList<Particle> particles;

PVector position = new PVector();
PVector jointPos = new PVector(0,0,0);
PVector min = new PVector(0,0,0);
PVector valY = new PVector(0,0,0);
PVector max = new PVector(0,0,0);
int kinectWidth = 640;
int kinectHeight = 480;
int maxValue = 2500;
float reScale;
int clickedDepth,clickPosition;

void setup(){
  size(800,600,OPENGL);
  background(0);
  reScale = (float) width / kinectWidth;
  
  box2d = new PBox2D(this);
  box2d.createWorld();
  particles = new ArrayList<Particle>();
  Vec2 gravity = new Vec2(0,-10);
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
}

void draw(){
  background(0);
  min.x = width;
  min.y = height;
  max.x = 0;
  max.y = 0;
  
  box2d.step();
  kinect.update();  
  int[] userMap = kinect.userMap(); 
  int[] userList = kinect.getUsers();
  PImage cam = createImage(640,480,RGB);

  if (kinect.getNumberOfUsers() > 0) {
    cam.loadPixels(); 
    for(int z = 0; z < userList.length; z++) {    
      for(int x = 0; x < 640; x++){           //See all the pixels
        for(int y = 0; y < 480; y++){ 
        
            int clickPosition = x + (y*640); 
            if (userMap[clickPosition] != 0) {
              cam.pixels[clickPosition] = color(255);
              if(x < min.x){
                min.x = x;
                valY.x = y;
              }
              if(x > max.x){
                max.x = x;
                valY.y = y;
              }
              if(y < min.y){
                min.y = y;
              }
              if(y > max.y){
                max.y = y;
              } 
            }
         }
       }
     }
    cam.updatePixels();
    translate(0, (height-kinectHeight*reScale)/2);
    scale(reScale);
    image(cam,0,0);
    if((max.x-min.x) > 200){
      Particle w = new Particle(min.x,valY.x);
      particles.add(w);
      Particle q = new Particle(max.x,valY.y);
      particles.add(q);      
    }
    
    for (Particle p: particles) {
      p.display();
    }    
  }
  
  
  println("coor: " + min.x + " , " + min.y + " , " + max.x + " , " + max.y );
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}


void mousePressed(){
  println("X: " + mouseX + "Y: " + mouseY);
}
