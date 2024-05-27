int numWedges = 10;
int radius = 500;
int jitter = 2;
int frameCounter = 0;
int interval = 2;

void setup()
{
    size( 880, 880 );
}

void draw()
{

    background(0);
    noFill();
    stroke(255);
    smooth();

    translate( 20, 20 );
    
    circle(width / 2, height / 2, radius);
    line(width / 2, height / 2, (width / 2) - radius, (width / 2) - radius);
    
    //if (frameCounter%(interval) == 0) {
    //    print("Doing the thing\n");
    //    for (int k = 0; k < (numRows + 1); k++) {
    //      for (int l = 0; l < (numRows + 1); l++) {
    //        vertices[l][k].x += int(random((-1 * jitter), jitter));
    //        vertices[l][k].y += int(random((-1 * jitter), jitter));
    //      }
    //    }
    //  }

    //for (int j = 0; j < numWedges; j ++) {
        
    //}
    //frameCounter++;
}
