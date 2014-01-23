import SimpleOpenNI.*;

class kinectSensor {
  SimpleOpenNI  context;
  boolean autoCalib = true;
  UserManager userManager;
  PVector offset;
  float scale = 1;
  int[] skelJointId;
  
  // ctor
  kinectSensor(processing.core.PApplet parent) {
    context = new SimpleOpenNI(parent);
//    context = new SimpleOpenNI(parent, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
    userManager = new UserManager(context);
    offset = new PVector(width/2, height*2/3);
    skelJointId = new int[]{SimpleOpenNI.SKEL_HEAD, 
                            SimpleOpenNI.SKEL_LEFT_FOOT,
                            
                            SimpleOpenNI.SKEL_LEFT_ELBOW,
                            SimpleOpenNI.SKEL_LEFT_FINGERTIP,
                            SimpleOpenNI.SKEL_LEFT_FOOT,
                            SimpleOpenNI.SKEL_LEFT_HAND,
                            SimpleOpenNI.SKEL_LEFT_HIP,
                            SimpleOpenNI.SKEL_LEFT_KNEE,
                            SimpleOpenNI.SKEL_LEFT_SHOULDER,
                            
                            SimpleOpenNI.SKEL_NECK,
                            SimpleOpenNI.SKEL_RIGHT_FOOT,
                            
                            SimpleOpenNI.SKEL_RIGHT_ELBOW,
                            SimpleOpenNI.SKEL_RIGHT_FINGERTIP,
                            SimpleOpenNI.SKEL_RIGHT_FOOT,
                            SimpleOpenNI.SKEL_RIGHT_HAND,
                            SimpleOpenNI.SKEL_RIGHT_HIP,
                            SimpleOpenNI.SKEL_RIGHT_KNEE,
                            SimpleOpenNI.SKEL_RIGHT_SHOULDER,
                            
                            };
   
  // enable depthMap generation 
    if(context.enableDepth() == false)
    {
       println("Can't open the depthMap, maybe the camera is not connected!"); 
       exit();
       return;
    }
  
    // enable skeleton generation for all joints
    context.enableUser();
    
    //context.enableHands();
    
//    context.alternativeViewPointDepthToImage();
  }  //ctor
  
  SimpleOpenNI getContext() {
    return context;  
  }
  
  void update() {
    context.update();  
  }

  boolean isTrackingSkeleton(int user) {
    return context.isTrackingSkeleton( user );
  }

  int[] getUsers() {
     return context.getUsers();
  }
    
  PImage depthImage() {
    return context.depthImage();  
  }


  int depthWidth(){
    return context.depthWidth(); 
  } 
  
  int depthHeight(){
    return context.depthHeight();
  }
  
  // draw the skeleton with the selected joints
  void drawSkeleton(int userId)
  {
    // to get the 3d joint data
    /*
    PVector jointPos = new PVector();
    context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
    println(jointPos);
    */
  
    drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

    drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
 
    drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

    drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

    drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
  }
  
  void displaySkeleton(int userId) {
    fill(255);
    textSize(16);
    float x, y, z;
    PVector rightHandPos = new PVector();
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND,rightHandPos);
    x = rightHandPos.x;
    y = rightHandPos.y;
    z = rightHandPos.z;
    x = (x + width) / 3;
    y = -(y - height) / 3;
    rightHandPos.set(x, y, z);

    text( rightHandPos.x, rightHandPos.x, rightHandPos.y ); 
    textSize(16); 
    text( "right hand x = "+ rightHandPos.x, 10, 50);  
//    println("right hand x = "+ rightHandPos.x);
    ellipse(rightHandPos.x, rightHandPos.y, 12, 12);
  }
  
  void displayInfo() {
 /** /    Display frame rate */
    fill( 255 );
    textSize( 16 );
    text( width + " x " + height, 10, 20 );
    text( "frameRate is : " + int(frameRate), 10, 40 );
/**/
  }

 void drawLimb(int userId,int jointType1,int jointType2)
  {
    PVector jointPos1 = new PVector();
    PVector jointPos2 = new PVector();
    float  confidence;
  
    // draw the joint position
    confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);
    confidence = context.getJointPositionSkeleton(userId,jointType2,jointPos2);

    stroke(255,0,0,confidence * 200 + 55);
 //   line(jointPos1.x,jointPos1.y,jointPos1.z,
 //      jointPos2.x,jointPos2.y,jointPos2.z);
    stroke(0,255,0,confidence * 200 + 55);
    
    pointCalibration(jointPos1);
    pointCalibration(jointPos2);
    
    line(jointPos1.x,jointPos1.y,
       jointPos2.x,jointPos2.y);
  
//    drawJointOrientation(userId,jointType1,jointPos1,50);
  }

  void pointCalibration(PVector joint) {
    pointCalibration(joint, offset, scale); 
  }

  void pointCalibration(PVector joint, PVector trans, float scale ) {
    joint.x = (joint.x + context.depthWidth()) * scale / 2.0;
    joint.y = -(joint.y - context.depthHeight()) * scale / 2.0;
    joint.add(trans);
  }

  void drawJointOrientation(int userId,int jointType,PVector pos,float length)
  {
    // draw the joint orientation  
    PMatrix3D  orientation = new PMatrix3D();
    float confidence = context.getJointOrientationSkeleton(userId,jointType,orientation);
    if(confidence < 0.001f) 
      // nothing to draw, orientation data is useless
      return;
    
    pushMatrix();
      translate(pos.x,pos.y,pos.z);
    
      // set the local coordsys
      applyMatrix(orientation);
    
      // coordsys lines are 100mm long
      // x - r
      stroke(255,0,0,confidence * 200 + 55);
      line(0,0,0,
           length,0,0);
      // y - g
      stroke(0,255,0,confidence * 200 + 55);
      line(0,0,0,
           0,length,0);
      // z - b    
      stroke(0,0,255,confidence * 200 + 55);
      line(0,0,0,
           0,0,length);
    popMatrix(); 
  }
  
  void getBodyDirection(int userId,PVector centerPoint,PVector dir)
  {
    PVector jointL = new PVector();
    PVector jointH = new PVector();
    PVector jointR = new PVector();
    float  confidence;
  
    // draw the joint position
    confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointL);
    confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointH);
    confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointR);
  
    // take the neck as the center point
    confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,centerPoint);
  
    /*  // manually calc the centerPoint
    PVector shoulderDist = PVector.sub(jointL,jointR);
    centerPoint.set(PVector.mult(shoulderDist,.5));
    centerPoint.add(jointR);
    */
  
    PVector up = new PVector();
    PVector left = new PVector();
  
    up.set(PVector.sub(jointH,centerPoint));
    left.set(PVector.sub(jointR,centerPoint));
  
    dir.set(up.cross(left));
    dir.normalize();
  }
}
