public class Mov {
  final static int N = 16;
  final static int SIZE = (N + 2) * (N + 2);  //how much cells/triangles are
  double[] u = new double[SIZE];              //for Dx
  double[] v = new double[SIZE];              //for Dy
  double[] u_prev = new double[SIZE];
  double[] v_prev = new double[SIZE];
  double[] tmp = new double[SIZE];
 
  public Mov() {
  }
 
  public double getDx(int x, int y) {
    return u[INDEX(x + 1, y + 1)];
  }
 
  public double getDy(int x, int y) {
    return v[INDEX(x + 1, y + 1)];
  }
 
  public void applyForce(int cellX, int cellY, double vx, double vy) {
    cellX += 1;
    cellY += 1;
    double dx = u[INDEX(cellX, cellY)];    //Retuns the cell postition as a pixel array
    double dy = v[INDEX(cellX, cellY)];
 
    u[INDEX(cellX, cellY)] = (vx != 0) ? PApplet.lerp((float) vx,
    (float) dx, 0.85f) : dx;
    v[INDEX(cellX, cellY)] = (vy != 0) ? PApplet.lerp((float) vy,
    (float) dy, 0.85f) : dy;
  }
 
  void tick(double dt, double visc, double diff) {
    vel_step(u, v, u_prev, v_prev, visc, dt);
  }
 
  final int INDEX(int i, int j) {
    return i + (N + 2) * j;
  }
  
  void vel_step(double[] u, double[] v, double[] u0, double[] v0,
    double visc, double dt) {
    diffuse(1, u, u, visc, dt);
    diffuse(2, v, v, visc, dt);
    project(u, v, u0, v0);
  }
  
  void diffuse(int b, double[] x, double[] x0, double diff, double dt) {
    int i, j, k;
    double a = dt * diff * N * N;
    for (k = 0; k < 20; k++) {
      for (i = 1; i <= N; i++) {
        for (j = 1; j <= N; j++) {
          x[INDEX(i, j)] = (x0[INDEX(i, j)] + a
            * (x[INDEX(i - 1, j)] + x[INDEX(i + 1, j)]
            + x[INDEX(i, j - 1)] + x[INDEX(i, j + 1)]))
            / (1 + 4 * a);
        }
      }
      set_bnd(b, x);
    }
  }
  
  void set_bnd(int b, double[] x) {
    int i;
    for (i = 1; i <= N; i++) {
      x[INDEX(0, i)] = (b == 1) ? -x[INDEX(1, i)] : x[INDEX(1, i)];
      x[INDEX(N + 1, i)] = b == 1 ? -x[INDEX(N, i)] : x[INDEX(N, i)];
      x[INDEX(i, 0)] = b == 2 ? -x[INDEX(i, 1)] : x[INDEX(i, 1)];
      x[INDEX(i, N + 1)] = b == 2 ? -x[INDEX(i, N)] : x[INDEX(i, N)];
    }
    x[INDEX(0, 0)] = 0.5 * (x[INDEX(1, 0)] + x[INDEX(0, 1)]);
    x[INDEX(0, N + 1)] = 0.5 * (x[INDEX(1, N + 1)] + x[INDEX(0, N)]);
    x[INDEX(N + 1, 0)] = 0.5 * (x[INDEX(N, 0)] + x[INDEX(N + 1, 1)]);
    x[INDEX(N + 1, N + 1)] = 0.5 * (x[INDEX(N, N + 1)] + x[INDEX(N + 1, N)]);
  }
 
  void project(double[] u, double[] v, double[] p, double[] div) {
    int i, j, k;
    double h;
    h = 1.0 / N;
    for (i = 1; i <= N; i++) {
      for (j = 1; j <= N; j++) {
        div[INDEX(i, j)] = -0.5
          * h
          * (u[INDEX(i + 1, j)] - u[INDEX(i - 1, j)]
          + v[INDEX(i, j + 1)] - v[INDEX(i, j - 1)]);
        p[INDEX(i, j)] = 0;
      }
    }
    set_bnd(0, div);
    set_bnd(0, p);
    for (k = 0; k < 20; k++) {
      for (i = 1; i <= N; i++) {
        for (j = 1; j <= N; j++) {
          p[INDEX(i, j)] = (div[INDEX(i, j)] + p[INDEX(i - 1, j)]
            + p[INDEX(i + 1, j)] + p[INDEX(i, j - 1)] + p[INDEX(
          i, j + 1)]) / 4;
        }
      }
      set_bnd(0, p);
    }
    for (i = 1; i <= N; i++) {
      for (j = 1; j <= N; j++) {
        u[INDEX(i, j)] -= 0.5
          * (p[INDEX(i + 1, j)] - p[INDEX(i - 1, j)]) / h;
        v[INDEX(i, j)] -= 0.5
          * (p[INDEX(i, j + 1)] - p[INDEX(i, j - 1)]) / h;
      }
    }
    set_bnd(1, u);
    set_bnd(2, v);
  }
}
