// Physics
float x0 = 800;
float y0 = 300;
float x1 = 900;
float y1 = 500;
float x2 = 800;
float y2 = 700;
float vx1 = 0;
float vy1 = 0;
float vx2 = 0;
float vy2 = 0;
float l1 = 200;
float l2 = 200;
float m1 = 30;
float m2 = 30;
float k1 = 10;
float k2 = 10;
float g = 10;

boolean start = false;

// Time
long previousFrameTime = -1;

void setup() {
    size(1600, 900);
    background(100);
    previousFrameTime = millis();
}

void mouseDragged() {
  if((mouseX - x1) * (mouseX - x1) + (mouseY - y1) * (mouseY - y1) <= m1 * m1) {
      x1 = mouseX;
      y1 = mouseY;
      vx1 = 0;
      vy1 = 0;
  }
  if((mouseX - x2) * (mouseX - x2) + (mouseY - y2) * (mouseY - y2) <= m2 * m2) {
      x2 = mouseX;
      y2 = mouseY;
      vx2 = 0;
      vy2 = 0;
  }
}

void keyPressed() {
    start = true;
}

void draw() {
    // Calculate dt
     long time = millis();
     long deltaTimel = time - previousFrameTime;
     previousFrameTime = time;
     float dt = deltaTimel / 1000.f;
     dt *= 3;
    //float dt = 3.f / 60.f;

    if(start) {
        // Calculate physics
        float a1 = atan((x1 - x0) / (y1 - y0));
        float a2 = atan((x2 - x1) / (y2 - y1));
        float cl1 = sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
        float cl2 = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        float ds1 = cl1 - l1;
        float ds2 = cl2 - l2;
        float dx1 = ds1 * sin(a1);
        float dy1 = ds1 * cos(a1);
        float dx2 = ds2 * sin(a2);
        float dy2 = ds2 * cos(a2);
        float ddx1 = (k2 / m1) * dx2 - (k1 / m1) * dx1;
        float ddy1 = g + (k2 / m1) * dy2 - (k1 / m1) * dy1;
        float ddx2 = -(k2 / m2) * dx2;
        float ddy2 = g - (k2 / m2) * dy2;
        vx1 += ddx1 * dt;
        vy1 += ddy1 * dt;
        vx2 += ddx2 * dt;
        vy2 += ddy2 * dt;
        x1  += vx1  * dt;
        y1  += vy1  * dt;
        x2  += vx2  * dt;
        y2  += vy2  * dt; 
    }

    // Display
    background(50);
    stroke(200);
    strokeWeight(2);
    line(x0, y0, x1, y1);
    line(x1, y1, x2, y2);
    noStroke();
    rect(x0 - 5, y0 - 5, 10, 10);
    ellipse(x1, y1, m1, m1);
    ellipse(x2, y2, m2, m2);

    saveFrame("output_60fps/double_spring_####.tga");
}
