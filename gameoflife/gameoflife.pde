int hcells = 100;
int vcells = 100;
int[][] cells;

void applyPattern(int[][] cells, int[][] pattern, int x, int y) {
  for(int i = 0; i < pattern.length; i++) {
    cells[y + pattern[i][1]][x + pattern[i][0]] = 1;
  }
}

void setup() {
  size(800, 800);
  cells = new int[vcells][hcells];
  for(int i = 0; i < vcells; i++) {
    for(int j = 0; j < hcells; j++) {
       cells[i][j] = 0;
    }
  }
  int[][] pat_ship = {{0, 0,}, {1, 0}, {0, 1}, {1, 2}, {2, 1}, {2, 2}};
  int[][] pat_pyr = {{0, 1}, {1, 0}, {1, 1}, {2, 1}};
  int[][] pat_explorer = {{0, 0}, {0, 1}, {0, 2}, {0, 3}, {0, 4}, {2, 0}, {2, 4}, {4, 0}, {4, 1}, {4, 2}, {4, 3}, {4, 4}};
  //applyPattern(cells, pat_ship, hcells / 2, vcells / 2);
  //applyPattern(cells, pat_pyr, hcells / 2, vcells / 2);
  applyPattern(cells, pat_explorer, hcells / 2, vcells / 2);
  frameRate(4);
}

void process() {
  int[][] newcells = new int[vcells][hcells];
  for(int i = 0; i < vcells; i++) {
    for(int j = 0; j < hcells; j++) {
       newcells[i][j] = 0;
    }
  }
  for(int i = 0; i < vcells; i++) {
    for(int j = 0; j < hcells; j++) {
      int onecount = 0;
      for(int a = -1; a <= 1; a++) {
        for(int b = -1; b <= 1; b++) {
          int x = j + b;
          int y = i + a;
          if(x >= 0 && x < hcells && y >= 0 && y < vcells) {
            onecount += cells[y][x];
          }
        }
      }
      onecount -= cells[i][j];
      newcells[i][j] = cells[i][j];
      if(cells[i][j] == 1) {
        if(onecount < 2 || onecount > 3) {
          newcells[i][j] = 0;
        }
      } else {
        if(onecount == 3) {
          newcells[i][j] = 1;
        }
      }
    }
  }
  cells = newcells;
}

void draw() {
  float cellw = width / hcells;
  float cellh = height / vcells;
  
  background(50);
  fill(200);
  strokeWeight(0);
  for(int i = 0; i < vcells; i++) {
    for(int j = 0; j < hcells; j++) {
      if(cells[i][j] > 0) {
        rect(j * cellw, i * cellh, cellw, cellh);
      }
    }
  }
  
  //stroke(150);
  //strokeWeight(1);
  //for(float y = 0; y <= height; y += cellh) {
  //  line(0, y, width, y);
  //}
  //for(float x = 0; x <= width; x += cellw) {
  //  line(x, 0, x, height);
  //}
  
  process();
}
