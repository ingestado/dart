public class Copo{
  public float lado = 10;
  public float x;
  public float y;
}
  
private void initCopos(){
    for (int i = 0; i < numCopos; i++) {
      copos[i] = new Copo();
      copos[i].x = random(width);
      copos[i].y = random(height);
    }  
}
 
private void drawCopos() {
  
  for (Copo p : copos) {
    
    int cellX = floor(p.x / cellWidth);
      int cellY = floor(p.y / cellHeight);
      float dx = (float) mov.getDx(cellX, cellY);
      float dy = (float) mov.getDy(cellX, cellY);
 
      float lX = p.x - cellX * cellWidth - cellWidth / 2;    //Take the distance to the center of the cell
      float lY = p.y - cellY * cellHeight - cellHeight / 2;
 
      int v, h, vf, hf;
 
      if (lX > 0) {
        v = Math.min(n, cellX + 1);
        vf = 1;
      }
      else {
        v = Math.max(0, cellX - 1);
        vf = -1;
      }
 
      if (lY > 0) {
        h = Math.min(n, cellY + 1);
        hf = 1;
      }
      else {
        h = Math.max(0, cellY - 1);
        hf = -1;
      }
 
      float dxv = (float) mov.getDx(v, cellY);
      float dxh = (float) mov.getDx(cellX, h);
      float dxvh = (float) mov.getDx(v, h);
 
      float dyv = (float) mov.getDy(v, cellY);
      float dyh = (float) mov.getDy(cellX, h);
      float dyvh = (float) mov.getDy(v, h);
 
      dx = lerp(lerp(dx, dxv, vf * lX / cellWidth),
      lerp(dxh, dxvh, vf * lX / cellWidth),
      hf * lY / cellHeight);
 
      dy = lerp(lerp(dy, dyv, vf * lX / cellWidth),
      lerp(dyh, dyvh, vf * lX / cellWidth),
      hf * lY / cellHeight);
 
      p.x += dx * vScale;    //move the particle depending mouse move.
      p.y += dy * vScale;
 
      if (p.x < 0 || p.x >= width) {
        p.x = random(width);
      }
      if (p.y < 0 || p.y >= height) {
        p.y = random(height);
      }
 
      set((int) p.x, (int) p.y, c);
    
   noFill();
   stroke(255);
   line(p.x,p.y-p.lado/2,p.x,p.y+p.lado/2); 
   line(p.x,p.y-p.lado/3,p.x+p.lado/6,p.y-p.lado/2); 
   line(p.x,p.y-p.lado/3,p.x-p.lado/6,p.y-p.lado/2);  
   line(p.x,p.y+p.lado/3,p.x+p.lado/6,p.y+p.lado/2); 
   line(p.x,p.y+p.lado/3,p.x-p.lado/6,p.y+p.lado/2);
   line(p.x-p.lado/2,p.y,p.x+p.lado/2,p.y);
   line(p.x-p.lado/3,p.y,p.x-p.lado/2,p.y+p.lado/6); 
   line(p.x-p.lado/3,p.y,p.x-p.lado/2,p.y-p.lado/6);  
   line(p.x+p.lado/3,p.y,p.x+p.lado/2,p.y-p.lado/6); 
   line(p.x+p.lado/3,p.y,p.x+p.lado/2,p.y+p.lado/6);
   pushMatrix();
   noFill();
   stroke(255);
   translate(p.x,p.y,0);
   rotateZ(radians(45));
   line(0,-p.lado/2,0,p.lado/2);
   line(0,-p.lado/3,p.lado/6,-p.lado/2); 
   line(0,-p.lado/3,-p.lado/6,-p.lado/2);  
   line(0,p.lado/3,p.lado/6,p.lado/2); 
   line(0,p.lado/3,-p.lado/6,p.lado/2);
   rotateZ(radians(90));
   line(0,-p.lado/2,0,p.lado/2);
   line(0,-p.lado/2,0,p.lado/2);
   line(0,-p.lado/3,p.lado/6,-p.lado/2); 
   line(0,-p.lado/3,-p.lado/6,-p.lado/2);  
   line(0,p.lado/3,p.lado/6,p.lado/2); 
   line(0,p.lado/3,-p.lado/6,p.lado/2);
   popMatrix();
  }
}
