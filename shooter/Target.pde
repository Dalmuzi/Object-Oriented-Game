class Target {

  PVector pos;
  PVector vel;
  float size;

  Target() {

    size = random(40, 70);

    float y = random(120, height - 100);
    float x = random(1) < 0.5 ? -size : width + size;

    pos = new PVector(x, y);

    float direction = (x < width/2) ? 1 : -1;
    vel = new PVector(direction * random(2, 4), 0);
  }

  void update() {
    pos.x += vel.x * speedMultiplier;

    if (pos.x < -size) pos.x = width + size;
    if (pos.x > width + size) pos.x = -size;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    
    stroke(0);
    strokeWeight(3);
    noFill();
    
    ellipse(0, -size*0.4, size*0.25, size*0.25);
    line(0, -size*0.3, 0, size*0.1);
    line(-size*0.2, -size*0.15, size*0.2, -size*0.15);
    line(0, size*0.1, -size*0.2, size*0.35);
    line(0, size*0.1, size*0.2, size*0.35);
    
    popMatrix();
  }
}
