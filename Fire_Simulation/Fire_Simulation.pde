ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

void setup() {
  size(800, 600, P3D);
  //frameRate(5);
  // frameRate(1);
  wind = new PVector(0.01, 0);
  gravity = new PVector(0, 1);
  for (int i=0; i < 500; i++) {
    particleSystem.particles.add(new Particle(random(width), random(height), random(40), 40));
  }
}

void draw() {
  background(0);
  noStroke();
  lights();
  wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.002);
  particleSystem.update();
  particleSystem.render();
}
