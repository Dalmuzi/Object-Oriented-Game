import processing.sound.*;

ArrayList<Target> targets;
Scope scope;
int score = 0;
int hp = 5;
boolean playing = true;
PVector worldOffset;
float speedMultiplier = 1;
SoundFile soundEffect;

void setup() {
  size(400, 400);
  soundEffect = new SoundFile(this,"Gunshot Sound Effect.wav");
  
  targets = new ArrayList<Target>();
  scope = new Scope();
  worldOffset = new PVector(0, 0);

  for (int i = 0; i < 5; i++)
    targets.add(new Target());
}

void draw() {
  background(100);

  if (playing) playGame();
  else gameOver();
}

void playGame() {
  scope.update();

  pushMatrix();
  translate(worldOffset.x, worldOffset.y);

  for (Target t : targets) {
    t.update();
    t.display();
  }

  popMatrix();

  scope.display();  

  HPBullet(); 

  fill(0);
  text("Score: " + score, 10, 380);

  if (frameCount % 130 == 0)
    targets.add(new Target());

  if (hp <= 0) playing = false;
}

void mousePressed() {
  soundEffect.play();
  if (!playing) return;

  boolean hitSomething = false;

  float sx = width/2;
  float sy = height/2;
  float scopeRadius = 75;     
  float hitZone = 20;        

  for (int i = targets.size()-1; i >= 0; i--) {
    Target t = targets.get(i);

    float wx = t.pos.x + worldOffset.x;
    float wy = t.pos.y + worldOffset.y;
    float d = dist(wx, wy, sx, sy);

    if (d < scopeRadius && d < hitZone) {

      score++;
      hitSomething = true;
      targets.remove(i);

      if (score % 5 == 0) speedMultiplier += 0.4;
    }
  }

  if (!hitSomething) hp--;
}

void keyPressed() {
  if (!playing && key == 'r') restart();
}

void restart() {
  targets.clear();
  for (int i = 0; i < 5; i++) targets.add(new Target());

  score = 0;
  hp = 5;
  speedMultiplier = 1;
  worldOffset.set(0, 0);

  playing = true;
}

void HPBullet() {
  for (int i = 0; i < hp; i++) {
    fill(255, 220, 0);              
    rect(280 + i*20, 20, 15, 35, 4);
  }
}

void gameOver() {
  background(0, 156, 58);

  fill(0);
  textAlign(CENTER);
  textSize(32);
  text("GAME OVER", width/2, height/2 - 20);

  textSize(20);
  text("Press R to Restart", width/2, height/2 + 20);
}
