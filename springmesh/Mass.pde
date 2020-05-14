class Mass {
    public long idx;
    public float x;
    public float y;
    public float m;
    private float vx;
    private float vy;
    private float ax;
    private float ay;
    private boolean lock;
    private ArrayList<Spring> springs;

    Mass(float x, float y, float m) {
        this.x = x;
        this.y = y;
        this.m = m;
        this.vx = 0;
        this.vy = 0;
        this.lock = false;
        this.springs = new ArrayList<Spring>();
        Physics.addMass(this);
    }

    void lock() {
        lock = true;
    }

    void attach(Spring spring) {
        this.springs.add(spring);
        spring.ends.add(this);
    }

    // Calculates ax, ay
    void update() {
        if(this.lock) return;

        float fx = 0;
        float fy = this.m * Physics.g;
        for(Spring spring : springs) {
            Mass other = spring.otherEnd(this);
            float ox = other.x;
            float oy = other.y;
            float dx = ox - this.x;
            float dy = oy - this.y;

            float l = sqrt(dx * dx + dy * dy);
            float s = l - spring.l;
            float f = this.m * spring.k * s;
            float ffx = f * (dx / l);
            float ffy = f * (dy / l);
            fx += ffx;
            fy += ffy;
        }
        fx += -this.vx * Physics.damp; 
        fy += -this.vy * Physics.damp;
        fx += 1000 * this.m * sin(Physics.t * 0.5); //* map(y, 0, height, 1, 0);

        this.ax = fx / this.m;
        this.ay = fy / this.m;
    }

    // Calculates vx, vy, x, y
    void move() {
        if(this.lock) return;

        vx += ax * Physics.dt;
        vy += ay * Physics.dt;
        x += vx * Physics.dt;
        y += vy * Physics.dt;
    }
}
