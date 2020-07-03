Bubble[] bubbles = new Bubble[5];
float[][] field;
int rez = 20;
int cols, rows;

void setup() {
  size(640, 480);
  randomSeed(2);
  cols = 1 + width / rez;
  rows = 1 + height / rez;
  field = new float[cols][rows];
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i] = new Bubble();
  }
}

void line(PVector v1, PVector v2) {
  line(v1.x, v1.y, v2.x, v2.y);
}

void draw() {
  background(0); 


  for (int i = 0; i < cols; i++) {
    float x = i * rez;
    stroke(255, 100);
    line(x, 0, x, height);
  }

  for (int i = 0; i < rows; i++) {
    float y = i * rez;
    stroke(255, 100);
    line(0, y, width, y);
  }


  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float sum = 0;
      float x = i * rez;
      float y = j * rez;

      for (Bubble b : bubbles) {
        sum += b.r*b.r / ((x-b.x)*(x-b.x) + (y-b.y)*(y-b.y));
      }
      field[i][j] = sum;
    }
  }


  for (Bubble b : bubbles) {
    b.update();
    b.show();
  }


  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows-1; j++) {
      float x = i * rez;
      float y = j * rez;
      PVector a = new PVector(x + rez * 0.5, y            );
      PVector b = new PVector(x + rez, y + rez * 0.5);
      PVector c = new PVector(x + rez * 0.5, y + rez      );
      PVector d = new PVector(x, y + rez * 0.5);

      //PVector a = new  PVector(x, y);
      //PVector b = new  PVector(x+rez, y);
      //PVector c = new  PVector(x, y+rez);
      //PVector d = new  PVector(x+rez, y+rez);

      float threshold = 1;
      int c1 = field[i][j]  < threshold ? 0 : 1;
      int c2 = field[i+1][j]  < threshold ? 0 : 1;
      int c3 = field[i+1][j+1]  < threshold ? 0 : 1;
      int c4 = field[i][j+1]  < threshold ? 0 : 1;
      int state = getState(c1, c2, c3, c4);
      stroke(255);
      strokeWeight(2);
      float a_val = field[i][j];
      float b_val = field[i+1][j];
      float c_val = field[i][j+1];
      float d_val = field[i+1][j+1];      
      //float amt1 = (1 - a_val) / (c_val - a_val); 
      //float qx = a.x;
      //float qy = lerp(a.y, c.y, amt1);

      //float amt2 = (1 - d_val) / (c_val - d_val);
      //float px = lerp(c.x, d.x, amt2);
      //float py = c.y;
      //line(px, py, qx, qy);


      switch (state) {
      case 1:  
        line(c, d);
        break;
      case 2:  
        line(b, c);
        break;
      case 3:  
        line(b, d);
        break;
      case 4:  
        line(a, b);
        break;
      case 5:  
        line(a, d);
        line(b, c);
        break;
      case 6:  
        line(a, c);
        break;
      case 7:  
        line(a, d);
        break;
      case 8:  
        line(a, d);
        break;
      case 9:  
        line(a, c);
        break;
      case 10: 
        line(a, b);
        line(c, d);
        break;
      case 11: 
        line(a, b);
        break;
      case 12: 
        line(b, d);
        break;
      case 13: 
        line(b, c);
        break;
      case 14: 
        line(c, d);
        break;
      }
    }
  }
  noLoop();
}

int getState(int a, int b, int c, int d) {
  return a * 8 + b * 4  + c * 2 + d * 1;
}