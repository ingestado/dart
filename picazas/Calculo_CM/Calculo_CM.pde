


int maxImages = 3; //total number of images (examples)

PImage[] images = new PImage[maxImages];


void setup() {

  size(640,480);
  background(30);
   
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true); //setting up the kinect
  
  
 for (int i = 0; i < images.length; i ++ ) 
     //images[i] = loadImage( "image" + i + ".jpg" ); //calling up the photo array

  background(0);
}

void draw () {
  kinect.update();
  image(kinect.depthImage(), 0, 0);
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
 for (int i=0; i<userList.size(); i++){
    int userId = userList.get(i); //getting user data

    PVector position = new PVector();
    kinect.getCoM(userId, position);
    background(0);
    kinect.convertRealWorldToProjective(position, position);
    fill(255, 0, 0);
    println("userId: " + userId);
    println("position: " + position.x + ", " + position.y + ", " + position.z);

    image(kinect.depthImage(),0,0);
  } 
//the above line puts a photo onto the centre point- but it's running through all 3- I wanted it to pick one at random and stick with that- so how to split this line into two? 
 
}
