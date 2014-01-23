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

kinectSensor ks;
LineSystem ls;

/* dimensions of kinect screen * /
int w = 1280;
int h = 800;
*/
int w = 800;
int h = 600;

/* Configurable Params */
float VMIN = 0.003;  // v as velocity. line with velocity < vmin stops moving.
float VMAX = 20;  // v as diff of points positions. considered as the max velocity of human movements.
float VFACTOR = 2000;   // we divide v as diff of points positions between this factor to obtain velocity of rotation of the line.  

float DECELERATION = 0.003; // number of radians decreased in each iteration.
int N = 40;    // Number of lines per dimension x, y.

PVector pJoint = new PVector(0,0);

void setup()
{
  noLoop();
//  size(w,h, P2D);  
  size(displayWidth, displayHeight,P2D);
//  size(1024,768,P2D);

  ks = new kinectSensor(this); 
  ls = new LineSystem(N, N);
  w = ks.depthWidth();
  h = ks.depthHeight();
  println(w + " x " + h);

  stroke(0,0,255);
  strokeWeight(3);
  smooth();
/** /  
  println( "HEAD_ID = " + SimpleOpenNI.SKEL_HEAD );
  println( "RIGHT_FOOT_ID = " + SimpleOpenNI.SKEL_RIGHT_FOOT ); 
  println( "LEFT_FOOT_ID = " + SimpleOpenNI.SKEL_LEFT_FOOT ); 
/ **/
  loop();
}

void draw()
{
  background(0);
/* Sensor */
  ks.update();  
  drawSkeleton();

/* Control */
  checkCrash();

/* Actuator */
  ls.update();
  ls.display();
//  draw depthImageMap
//  image(ks.depthImage(),0,0);
  displayInfo();

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

void checkCrash() {
  PVector joint = new PVector();
  int i = 0;
  int n = 1;
  
  int[] userList = ks.getUsers();
  for(int u = 0; u < userList.length; u++) {
    if(ks.isTrackingSkeleton(userList[u])) {
//      for(int j = SimpleOpenNI.SKEL_HEAD; j < SimpleOpenNI.SKEL_RIGHT_FOOT; j++) {
      for(int j = 0; j < ks.skelJointId.length; j++) {
        ks.getContext().getJointPositionSkeleton(userList[u], ks.skelJointId[j], joint);
//        ks.getContext().getJointPositionSkeleton(userList[u], SimpleOpenNI.SKEL_RIGHT_HAND, joint);
        ks.pointCalibration(joint);
        ls.checkCrashes(joint, pJoint);
        pJoint = joint.get();
      }
    }
  }
}

/* kinect events callback * /

void onNewUser( int userId ) {
  ks.onNewUser(userId); 
} 

void onLostUser(int userId) {
  ks.onLostUser(userId);
}

void onExitUser(int userId) {
  ks.onExitUser(userId);
}

void onReEnterUser(int userId) {
  ks.onReEnterUser( userId);
}

void onStartCalibration(int userId) {
  ks.onStartCalibration(userId);
}

void onEndCalibration(int userId, boolean successfull) {
  ks.onEndCalibration(userId, successfull);
}

void onStartPose(String pose,int userId) {
  ks.onStartPose(pose, userId);
}

void onEndPose(String pose,int userId) {
  ks.onEndPose(pose, userId);
}

/* lineSystem events */
void mouseMoved() {
//  ls.mouseMoved();
}

