final float HEAT_DIFFUSION_RADIUS = 1;
final float CONTAINER_HEIGHT = 500;
final float CONTAINER_WIDTH = 400;
final float CONTAINER_LENGTH = 100;

ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

void setup() {
  size(400, 600, P3D);
  //frameRate(5);
  // frameRate(1);
  wind = new PVector(0.01, 0);
  gravity = new PVector(0, 0.6);
  for (int i=0; i < 2000; i++) {
    particleSystem.particles.add(new Particle(random(width), random(500), random(100), random(20)));
  }
}

void draw() {
  background(0);
  noStroke();
  lights();
  wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.00005);
  particleSystem.update();
  particleSystem.render();
}
