ArrayList<FireParticle> particles = new ArrayList<FireParticle>();
PVector wind;
PVector gravity;

void setup() {
  size(800, 600, P3D);
  // frameRate(1);
  wind = new PVector(0.01, 0);
  gravity = new PVector(0, 0.02);
  for (int i=0; i < 200; i++) {
    particles.add(new FireParticle(random(width), random(height), random(300), 10));
  }
}

void draw() {
  background(0);
  noStroke();
  lights();
  wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.0001);
  for (FireParticle p : particles) {
    p.update(wind, gravity);
    p.render();
  }
}
