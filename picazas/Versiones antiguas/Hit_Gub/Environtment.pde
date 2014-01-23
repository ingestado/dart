import SimpleOpenNI.*;

int RIGHT_HAND = 17;
int LEFT_HAND = 6;

public class Environment extends SimpleOpenNI {
  ArrayList<User> users;
  UserManager usermanager;
  
  // ctor
  Environment(processing.core.PApplet parent) {
    super(parent);
//    super(parent, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
    users = new ArrayList<User>();
    usermanager = new UserManager(this, users);

    if(enableDepth() == false) {
      println("Can't open the depthMap, maybe the camera is not connected!"); 
      exit();
      return;
    }
  
    // enable skeleton generation for all joints
    enableUser(SimpleOpenNI.SKEL_PROFILE_ALL, usermanager);

   } // ctor
  
  void drawSkeletons() {
    for( User u : users ) {
      if(isTrackingSkeleton(u.getId())){ 
        u.drawSkeleton();
        u.displayVelocities();
      }
    }
  }
  
  void update() {
    super.update();
    for( User u : users ) {
      if(isTrackingSkeleton(u.getId())) u.update();   
    }  
  }
}

