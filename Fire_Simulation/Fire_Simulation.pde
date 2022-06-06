ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

void setup() {
  size(800, 600, P3D);
  // frameRate(1);
  wind = new PVector(0.01, 0);
  gravity = new PVector(0, 1);
  for (int i=0; i < 200; i++) {
    particleSystem.particles.add(new Particle(random(width), random(height), random(300), 10));
  }
}

void draw() {
  background(0);
  noStroke();
  lights();
  wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.0002);
  particleSystem.update();
  particleSystem.render();
}
