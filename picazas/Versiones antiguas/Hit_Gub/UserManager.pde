public class UserManager
{
  protected SimpleOpenNI _context;
  protected ArrayList<User> _users;
  boolean             _autoCalib=true;
  
  public UserManager(Environment context, ArrayList<User> users )
  {
    _context = context;
    _users = users;
  }
    
  public void onNewUser(int userId)
  {
    println("onNewUser - userId: " + userId);
    println("  start pose detection");

    User newUser = new User( userId, _context );
    _users.add( newUser );

  if(_autoCalib)
    _context.requestCalibrationSkeleton(userId,true);
  else    
    _context.startPoseDetection("Psi",userId);  
    
  }

  public void onLostUser(int userId)
  {
    println("onLostUser - userId: " + userId);
  }

  public void onExitUser(int userId)
  {
    println("onExitUser - userId: " + userId);
  }

  public void onReEnterUser(int userId)
  {
    println("onReEnterUser - userId: " + userId);
  }

  public void onStartCalibration(int userId)
  {
    println("onStartCalibration - userId: " + userId);
  }

  public void onEndCalibration(int userId, boolean successfull)
  {
    println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

    if (successfull) 
    { 
      println("  User calibrated !!!");
      _context.startTrackingSkeleton(userId);
    } 
    else 
    { 
      println("  Failed to calibrate user !!!");
      println("  Start pose detection");
      _context.startPoseDetection("Psi", userId);
    }
  }

  public void onStartPose(String pose, int userId)
  {
    println("onStartdPose - userId: " + userId + ", pose: " + pose);
    println(" stop pose detection");

    _context.stopPoseDetection(userId); 
    _context.requestCalibrationSkeleton(userId, true);
  }

  public void onEndPose(String pose, int userId)
  {
    println("onEndPose - userId: " + userId + ", pose: " + pose);
  }
}
