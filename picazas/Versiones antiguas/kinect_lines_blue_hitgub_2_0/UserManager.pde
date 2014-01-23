public class UserManager
{
  protected SimpleOpenNI  _context;
  boolean             _autoCalib=true;
  
  public UserManager(SimpleOpenNI context)
  {
    _context = context;
  }
  
  public void onNewUser(int userId)
  {
    println("onNewUser - userId: " + userId);
    println("  start pose detection");



  
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

    }
  }

  public void onStartPose(String pose, int userId)
  {
    println("onStartdPose - userId: " + userId + ", pose: " + pose);
    println(" stop pose detection");



  }

  public void onEndPose(String pose, int userId)
  {
    println("onEndPose - userId: " + userId + ", pose: " + pose);
  }
}
