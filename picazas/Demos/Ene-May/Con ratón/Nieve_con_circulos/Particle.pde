public class Particle {
  public float x;
  public float y;
}

private void initParticles() {
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle();
    particles[i].x = random(width);
    particles[i].y = random(height);
  }
}

private void drawParticlesPixels() {
 
  int n = Mov.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
 
  for (Particle p : particles) {
    if (p != null) {              //There are particles
 
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
    }
  }
}


