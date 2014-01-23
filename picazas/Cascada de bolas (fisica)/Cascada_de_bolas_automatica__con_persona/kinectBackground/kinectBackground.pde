import oscP5.*;
import netP5.*;

OscP5 oscP5;
int backColor = 255;
void setup() {
    size(640, 480); 
   oscP5 = new OscP5(this, "127.0.0.1", 7110);
   
}
void draw(){
  background(backColor);
}
void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();
  if (addr.startsWith("/joint")){
    String bodyPart = msg.get(0).stringValue();
    //int userId = msg.get(1).intValue();
    if(bodyPart.equals("l_hand")){  
      //float x = msg.get(2).floatValue();
      float y = msg.get(3).floatValue();
      //float z = msg.get(4).floatValue();
      backColor = int(map(y, 0, 1, 0, 255));
    }
   }
}
