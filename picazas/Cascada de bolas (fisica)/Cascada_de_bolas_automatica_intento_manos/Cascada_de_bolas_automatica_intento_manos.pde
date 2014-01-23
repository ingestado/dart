import fisica.*;
FWorld world;

import java.util.Map;
import java.util.Iterator;

import SimpleOpenNI.*;
SimpleOpenNI kinect;

int cuentaB = 0;
int cuentaT = 0;

int handVecListSize = 20;
Map<Integer,ArrayList<PVector>>  handPathList = new HashMap<Integer,ArrayList<PVector>>();
color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };

void setup() {
  size(640, 480);
  smooth();
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);
 //kinect.enableUser();
  
  Fisica.init(this);

  world = new FWorld();
  world.setEdges();
  world.remove(world.top);

  FCircle bola = new FCircle(40);
  bola.setPosition(width/3, height/2); //Begin position
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola);
  
}

void draw() {
  
  kinect.update();
    
  cuentaT++;
  if (cuentaB < 51 && cuentaT == 30){
  float radius = random(20, 40);
  FCircle bola = new FCircle(radius);
  bola.setPosition(random(30,640), random(30,100));
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola); 
  cuentaT = 0; 
  cuentaB ++;
  }
  image(kinect.depthImage(),0,0);
  
 /* int[] valuesUser = kinect.getUserPixels();
  for(int x = 0; x < 640; x++){           //See all the pixels
    for(int y = 0; y < 480; y++){
      clickPosition = x + (y*640);
      for(int i = 0; i<valuesUser.length; i++){
      if( clickPosition != valuesUser[i])
      { fill(0);
      point (x,y);
      }
    }
  }*/
  if(handPathList.size() > 0)  
  {    
    Iterator itr = handPathList.entrySet().iterator();     
    while(itr.hasNext())
    {
      Map.Entry mapEntry = (Map.Entry)itr.next(); 
      int handId =  (Integer)mapEntry.getKey();
      ArrayList<PVector> vecList = (ArrayList<PVector>)mapEntry.getValue();
      PVector p;
      PVector p2d = new PVector();
      
        stroke(userClr[ (handId - 1) % userClr.length ]);
        noFill(); 
        strokeWeight(1);        
        Iterator itrVec = vecList.iterator(); 
        beginShape();
          while( itrVec.hasNext() ) 
          { 
            p = (PVector) itrVec.next(); 
            
            kinect.convertRealWorldToProjective(p,p2d);
            vertex(p2d.x,p2d.y);
          }
        endShape();   
  
        stroke(userClr[ (handId - 1) % userClr.length ]);
        strokeWeight(4);
        p = vecList.get(0);
        kinect.convertRealWorldToProjective(p,p2d);
        point(p2d.x,p2d.y);
 
    }        
  }
  world.step();
  world.draw();
}

void mousePressed() {
  float radius = random(10, 40);
  FCircle bola = new FCircle(radius);
  bola.setPosition(mouseX, mouseY);
  bola.setDensity(0.2);
  bola.setFill(120, 120, 190);
  bola.setNoStroke();
  world.add(bola);  
}
