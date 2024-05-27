int numRows = 10;
int jitter = 2;
int frameCounter = 0;
int interval = 2;

PVector[][] vertices = new PVector[(numRows + 1)][(numRows + 1)];

void setup()
{
    size( 880, 880 );
    
    for (int j = 0; j < (numRows + 1); j++) {
        for (int i = 0; i < (numRows + 1); i++) {
            vertices[i][j] = new PVector( i*80 + random(-20, 20), j*80 + random(-20, 20) );
        }
    }
    
}

void draw()
{

    background(0);
    noFill();
    stroke(255);
    smooth();

    translate( 20, 20 );
    
    if (frameCounter%(interval) == 0) {
        print("Doing the thing\n");
        for (int k = 0; k < (numRows + 1); k++) {
          for (int l = 0; l < (numRows + 1); l++) {
            vertices[l][k].x += int(random((-1 * jitter), jitter));
            vertices[l][k].y += int(random((-1 * jitter), jitter));
          }
        }
      }

    for (int j = 0; j < 10; j ++) {
        beginShape(TRIANGLE_STRIP);
        for (int i = 0; i < 11; i++) {
            vertex( vertices[i][j].x, vertices[i][j].y );
            vertex( vertices[i][j+1].x, vertices[i][j+1].y );
        }
        endShape();
    }
    frameCounter++;
}
