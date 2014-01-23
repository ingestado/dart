public class User {
  int SKEL_NUM_JOINTS = 22;
  private int id;
  PVector[] jointPositionSkeleton;
  PVector[] pJointPositionSkeleton;
  PVector[] jointVelocitySkeleton;
  int[] skelJointId; 
  SimpleOpenNI _env;

  PVector offset;
  float scale = 0.5;
  float CONF_THRESHOLD = 0.001f;
 

  User( int userId, SimpleOpenNI env ) {
    _env = env;
    offset = new PVector(width/2, height*2/3); 
    skelJointId = new int[]{SimpleOpenNI.SKEL_HEAD, 
                            SimpleOpenNI.SKEL_LEFT_ANKLE,
                            SimpleOpenNI.SKEL_LEFT_COLLAR,
                            SimpleOpenNI.SKEL_LEFT_ELBOW,
                            SimpleOpenNI.SKEL_LEFT_FINGERTIP,
                            SimpleOpenNI.SKEL_LEFT_FOOT,
                            SimpleOpenNI.SKEL_LEFT_HAND, // 6
                            SimpleOpenNI.SKEL_LEFT_HIP,
                            SimpleOpenNI.SKEL_LEFT_KNEE,
                            SimpleOpenNI.SKEL_LEFT_SHOULDER,
                            SimpleOpenNI.SKEL_LEFT_WRIST,
                            SimpleOpenNI.SKEL_NECK,
                            SimpleOpenNI.SKEL_RIGHT_ANKLE,
                            SimpleOpenNI.SKEL_RIGHT_COLLAR,
                            SimpleOpenNI.SKEL_RIGHT_ELBOW,
                            SimpleOpenNI.SKEL_RIGHT_FINGERTIP,
                            SimpleOpenNI.SKEL_RIGHT_FOOT,
                            SimpleOpenNI.SKEL_RIGHT_HAND,  // 17
                            SimpleOpenNI.SKEL_RIGHT_HIP,
                            SimpleOpenNI.SKEL_RIGHT_KNEE,
                            SimpleOpenNI.SKEL_RIGHT_SHOULDER,
                            SimpleOpenNI.SKEL_RIGHT_WRIST
                            };

    jointPositionSkeleton = new PVector[SKEL_NUM_JOINTS];
    pJointPositionSkeleton = new PVector[SKEL_NUM_JOINTS];
    jointVelocitySkeleton = new PVector[SKEL_NUM_JOINTS];
    for( int i = 0; i < SKEL_NUM_JOINTS; i++ ) {
      jointPositionSkeleton[i] = new PVector();
      pJointPositionSkeleton[i] = new PVector();
      jointVelocitySkeleton[i] = new PVector();
    }
    id = userId;
  }

  void update() {
    // actualiza valores geometricos segun la medida de la kinect
    for( int i = 0; i < SKEL_NUM_JOINTS; i++ ) {
      _env.getJointPositionSkeleton(id, skelJointId[i], jointPositionSkeleton[i]);
      pointCalibration( jointPositionSkeleton[i] );
      jointVelocitySkeleton[i] = PVector.sub(jointPositionSkeleton[i], pJointPositionSkeleton[i]);
      pJointPositionSkeleton[i] = jointPositionSkeleton[i].get();
    }
  }

  void refresh() {
    // actualiza valores dinamicos (lo que ocurre entre frames)
    
  }

  void displayVelocities() {
    fill( 255 );
    textSize( 18 );
    for(int i = 0; i < SKEL_NUM_JOINTS; i++)
      text( jointVelocitySkeleton[i].magSq(), jointPositionSkeleton[i].x, jointPositionSkeleton[i].y );
  }

  int getId() {
    return id;
  }
 
  void pointCalibration(PVector joint) {
    pointCalibration(joint, offset, scale); 
  }


  void pointCalibration(PVector joint, PVector trans, float scale ) {
    joint.x = (joint.x + _env.depthWidth()) * scale / 2.0;
    joint.y = -(joint.y - _env.depthHeight()) * scale / 2.0;
    joint.add(trans);
  }
 

  void drawSkeleton() {
    int userId = id;
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
    ellipseMode(CENTER); 
    int rx = 0;
    int ry = 0;
    for( int i = 0; i < SKEL_NUM_JOINTS; i ++ ) {
      rx = round(jointVelocitySkeleton[i].x) * 5;
      ry = round(jointVelocitySkeleton[i].y) * 5;
      ellipse(jointPositionSkeleton[i].x, 
              jointPositionSkeleton[i].y,
              rx, ry);    
    } 

  }

  void drawLimb(int userId,int jointType1,int jointType2)
  {
    PVector jointPos1 = new PVector();
    PVector jointPos2 = new PVector();
    float  confidence;
  
    // draw the joint position
    confidence = _env.getJointPositionSkeleton(userId,jointType1,jointPos1);
    confidence = _env.getJointPositionSkeleton(userId,jointType2,jointPos2);

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
  
}
