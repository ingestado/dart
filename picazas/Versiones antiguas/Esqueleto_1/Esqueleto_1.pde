import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup(){
  size(640,480);
  kinect = new SimpleOpenNI (this);
  kinect.enableDepth();
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
}

void draw(){
  kinect.update();
  PImage depth = kinect.depthImage();
  image(depth,0,0);
  
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  if(userList.size()>0){
    int userId= userList.get(0);
    
    if( kinect.isTrackingSkeleton(userId)){
      PVector rightHand = new PVector();
      float confidence = kinect.getJointPositionSkeleton(userId,
      SimpleOpenNI.SKEL_LEFT_HAND,rightHand);
      
      PVector convertedRightHand = new PVector();
      kinect.convertRealWorldToProjective(rightHand,convertedRightHand);
      fill(255,0,0);
      ellipse(convertedRightHand.x,convertedRightHand.y,10,10);
    }
  }
}

void onNewUser (int userId){
  println("Star pose detection");
  kinect.startPoseDetection("Psi", userId);
}

void onEndCalibration (int userId, boolean successful){
  if (successful){
    println("User calibrated!!!!");
    kinect.startTrackingSkeleton(userId);
  }
  else{
    println("Failed to calibrate user");
    kinect.startPoseDetection("Psi", userId);
  }
}

void onStartPose(string pose, int userId){
  println("Started pose for user");
  kinect.stopPoseDetection(userId);
  kinect.requestCalibrationSkeleton(userId,true);
}

  
