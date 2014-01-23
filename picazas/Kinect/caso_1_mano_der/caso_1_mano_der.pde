import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup() {
  size(640, 480,P3D);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);
}

void draw() {
  kinect.update();
  image(kinect.depthImage(), 0, 0);
  int[] userList = kinect.getUsers();          // make a vector of ints to store the list of users
  println("1");
  if (userList.length > 0) {                   // if we found any users
    println("2");
                        // get the first user
    for(int z = 0; z < userList.length; z++) { 
    //if ( kinect.isTrackingSkeleton(userId)) {    // if we’re successfully calibrated
      println("3");
      int userId = userList[z];
      PVector rightHand = new PVector();
      kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,rightHand);

      PVector convertedRightHand = new PVector();
      kinect.convertRealWorldToProjective(rightHand, convertedRightHand);
      println(convertedRightHand.x, convertedRightHand.y);
      fill(255,0,0);
      ellipse(convertedRightHand.x, convertedRightHand.y, 10, 10);
    }
  }
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


void keyPressed()
{
  switch(key)
  {
  case ' ':
    kinect.setMirror(!kinect.mirror());
    break;
  }
}  


