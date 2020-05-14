Mass[] masses;
Spring[] springs;

int w = 60;
int h = 30;
float m = 0.1 / (w * h);
float k = 1500;

void setup() {
    size(1600, 900);
    masses = new Mass[w * h];
    springs = new Spring[w * (h - 1) + h * (w - 1)];

    float lx = width / (2.f * (w - 1));
    float ly = height / (2.f * (h - 1));
    float tlx = width / 4.f;
    float tly = height / 8.f;
    for(int i = 0; i < h; i++) {
        for(int j = 0; j < w; j++) {
            float x = tlx + j * lx;
            float y = tly + i * ly;
            masses[i * w + j] = new Mass(x, y, m);
        }
    }
    for(int i = 0; i < h; i++) {
        for(int j = 0; j < w - 1; j++) {
            Spring spring = new Spring(lx, k);
            masses[i * w + j].attach(spring);
            masses[i * w + j + 1].attach(spring);
            springs[i * (w - 1) + j] = spring;
        }
    }
    for(int i = 0; i < h - 1; i++) {
        for(int j = 0; j < w; j++) {
            Spring spring = new Spring(ly, k);
            masses[i * w + j].attach(spring);
            masses[i * w + j + w].attach(spring);
            springs[h * (w - 1) + i * w + j] = spring;
        }
    }
    masses[0].lock(); // top left
    masses[w - 1].lock(); // top right
    masses[(w - 1) / 2].lock();
    masses[(w - 1) / 4].lock();
    masses[(3 * (w - 1)) / 4].lock();
    
    Physics.setup();
}

void draw() {
    Physics.update();
    for(Mass mass : masses) {
        mass.update();
    }
    for(Mass mass : masses) {
        mass.move();
    }

    // Drawing
    background(50);
    noStroke();
    fill(200);
    for(Mass mass : masses) {
        mass.update();
    }

    stroke(200);
    strokeWeight(2);
    for(Spring spring : springs) {
        Mass m1 = spring.ends.get(0);
        Mass m2 = spring.ends.get(1);
        line(m1.x, m1.y, m2.x, m2.y);
    }
    strokeWeight(0);
    for(Mass mass : masses) {
        ellipse(mass.x, mass.y, 5, 5);
    }
    saveFrame("dampedoutput_60fps/spring_mesh_#####.tga");
}
