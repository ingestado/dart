void setup(){
noFill();
size(500,500);
}
void draw(){
background(255);
for(float i=1; i<20; i++){
pushMatrix();
translate(width/2,height/2);
scale(1/(i/mouseY*90),1/(i/mouseY*90));
rotate(radians(i*mouseX));
ellipse(0,0, 200,100);
popMatrix();
}
}
