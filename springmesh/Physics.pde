public static class Physics {
    public static float g = 600;
    public static float dt = 0; // delta time, seconds
    public static float t = 0; // time, seconds
    public static float damp = .001;

    private static long previousFrameTimel = 0;
    private static long startFrameTimel = 0;
    private static long objcount = 0;

    public static void setup() {
        startFrameTimel = System.currentTimeMillis();
        previousFrameTimel = 0;
    }

    public static void update() {
      long timel = System.currentTimeMillis() - startFrameTimel;
      long deltaTimel = timel - previousFrameTimel;
      previousFrameTimel = timel;
      
      dt = deltaTimel / 1000.f;
      dt = 1/60.f;
      //dt *= 0.1;
      t = timel / 1000.f;
      //t *= 0.1;
      t += dt;
    }

    public static void addMass(Mass mass) {
        mass.idx = objcount++;
    }
};
