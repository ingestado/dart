/* --------------------------------------------------------------------------
 * ----------------------------------------------------------------------------
 */ 

/* dimensions of kinect screen * /

int w = 1280;
int h = 800;
*/
int w = 800;
int h = 800;

Environment env;
ElementSystem es;

void setup()
{ 
//  size(displayWidth, displayHeight, P3D);
  size(w, h, P3D);
/*  if (frame != null) {
    frame.setResizable(true);
  }
 */
  env = new Environment(this);
  es = new ElementSystem();
  es.addElement( width/2, height/2 );
  //delay(5000);
  background(200,0,0);

  stroke(0,0,255);
//  strokeWeight(3);
  smooth();
//  frameRate(8);
}

float V_THRES = 40.0;

void draw()
{
  float n_elements;
  background(0);
  env.update();
  env.drawSkeletons();
  es.run();
  for( User u: env.users ){     
    if(env.isTrackingSkeleton(u.getId())){ 
      float magnitud = u.jointVelocitySkeleton[RIGHT_HAND].mag();
      if( magnitud > V_THRES  ) {
        n_elements = round(random(magnitud));
        es.addElement(u.jointPositionSkeleton[RIGHT_HAND], 
                      PVector.div(u.jointVelocitySkeleton[RIGHT_HAND], 3));
//        es.addElement(u.jointPositionSkeleton[LEFT_HAND], 
//                      PVector.div(u.jointVelocitySkeleton[LEFT_HAND], 3));
      }
    }
  }
  
}

void keyPressed()
{
  switch(key)
  {
  case ' ':
    env.setMirror(!env.mirror());
    break;
  }
}

void mouseClicked() {
  float n = random(7);
  for(int i = 0; i < 7; i++) {
    es.addElement(mouseX, mouseY);
  }  
}
