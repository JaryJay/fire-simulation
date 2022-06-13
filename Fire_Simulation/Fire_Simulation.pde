final int NUM_PARTICLES = 1600;
final float HEAT_DIFFUSION_RADIUS = 1;
final float CONTAINER_HEIGHT = 500;
final float CONTAINER_WIDTH = 500;
final float CONTAINER_LENGTH = 120;
final float HIDE_THRESHOLD = -1;
final color COLOR_1 = color(1, 1, 1);
final color COLOR_2 = color(204, 93, 2);
final color COLOR_3 = color(255, 150, 0);
final color COLOR_4 = color(255, 255, 255);

ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

void settings() {
  size(int(CONTAINER_WIDTH), int(CONTAINER_HEIGHT), P3D);
}

void setup() {
  //frameRate(5);
  // frameRate(1);
  wind = new PVector(0, 0);
  gravity = new PVector(0, 0.7);
  for (int i=0; i < NUM_PARTICLES; i++) {
    particleSystem.particles.add(new Particle(random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH), random(20)));
  }
}

void draw() {
  background(0);
  noStroke();
  lights();
  //wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.0005);
  particleSystem.update();
  particleSystem.render();
}
