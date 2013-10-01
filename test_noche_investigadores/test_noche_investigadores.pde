/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */
import SimpleOpenNI.*;

kinectSensor ks;
LineSystem ls;
ElementSystem es;

/* dimensions of kinect screen */
int w = 1280;
int h = 800;

/* Configurable Params for line system */
float VMIN = 0.003;  // v as velocity. line with velocity < vmin stops moving.
float VMAX = 20;  // v as diff of points positions. considered as the max velocity of human movements.
float VFACTOR = 2000;   // we divide v as diff of points positions between this factor to obtain velocity of rotation of the line.  
float DECELERATION = 0.003; // number of radians decreased in each iteration.
int N = 40;    // Number of lines per dimension x, y.

/* Configurable params for elements */
float V_THRES = 30000;  // velocity threshold above which we create ellipses.
float E_V_FACTOR = 3.0; // factor to divide arm velocity for element initial velocity.

PVector pJoint = new PVector(0,0,0); 
PVector joint = new PVector(0,0,0);

void setup()
{
  size( w, h, P3D);  
//  size(displayWidth, displayHeight,P2D);
//  size(1024,768,P2D);

  ks = new kinectSensor(this); 
  ls = new LineSystem(N, N);
  es = new ElementSystem();
  es.addElement( width/2, height/2 );
  w = ks.depthWidth();
  h = ks.depthHeight();
  println("depth screen is "+ w + " x " + h);

  background( 200, 0, 0 );

  stroke(0,0,255);
  strokeWeight(3);
  smooth();
}

boolean flagDrawSkel = true;
boolean flagDrawLines = true;
boolean flagDrawBubbles = true;

void draw() {
  background(0);
/* Sensor */
  ks.update();  
  if( flagDrawSkel ) drawSkeleton();
//  image(ks.depthImage(),0,0); //  draw depthImageMap
//  displayInfo();

/* Control */

  if( flagDrawLines) checkCrash();  // Line System

  if( flagDrawBubbles ) addElements(); // Elements System
  
/* Actuator */
 
  ls.update();
  if( flagDrawLines ) ls.display();
  if( flagDrawBubbles ) es.run();
}

void addElements() {
  PVector jointVelocity = new PVector(0,0,0);
  int[] userList = ks.getUsers();
  for(int u = 0; u < userList.length; u++) {
    if(ks.isTrackingSkeleton(userList[u])) {
      ks.getContext().getJointPositionSkeleton( userList[u], SimpleOpenNI.SKEL_RIGHT_HAND, joint );
      ks.pointCalibration( joint );
      jointVelocity = PVector.sub( joint, pJoint );
      float right_v = pow(jointVelocity.x, 2) + pow(jointVelocity.x,2);
      println( "right_v = " + right_v ); 
      if( right_v > V_THRES  ) {
          es.addElement(joint, PVector.div( jointVelocity, E_V_FACTOR ) );
      }  // if add element
      pJoint = joint.get();
    }  // if
  }  // for 
}

void checkCrash() {  
  int[] userList = ks.getUsers();
  for(int u = 0; u < userList.length; u++) {
    if(ks.isTrackingSkeleton(userList[u])) {
      for(int j = 0; j < ks.skelJointId.length; j++) {
        ks.getContext().getJointPositionSkeleton(userList[u], ks.skelJointId[j], joint);
        ks.pointCalibration(joint);
        ls.checkCrashes(joint, pJoint);
        pJoint = joint.get();
      }
    }
  }
}

void drawSkeleton() {
  // draw the skeleton if it's available
  int[] userList = ks.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(ks.isTrackingSkeleton(userList[i]))
      ks.drawSkeleton(userList[i]);
  }    
}

void displayInfo() {
 /** /    Display frame rate */
  fill( 255 );
  textSize( 16 );
  text( width + " x " + height, 10, 20 );
  text( "frameRate is : " + int(frameRate), 10, 40 );
/**/
}

void keyPressed() {
  switch(key) {
    case 's' :
      flagDrawSkel = !flagDrawSkel;
      break;
    case 'l' :
      flagDrawLines = !flagDrawLines;
      break;
    case 'b' :
      flagDrawBubbles = !flagDrawBubbles;
      break;
  }  
}

/* lineSystem events */
void mouseMoved() {
//  ls.mouseMoved();
}



