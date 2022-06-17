import java.util.List;

final int NUM_PARTICLES = 0;
final float HEAT_DIFFUSION_RADIUS = 1;
final float CONTAINER_HEIGHT = 500;
final float CONTAINER_WIDTH = 500;
final float CONTAINER_LENGTH = 250;
final float GRAVITY = 0.7;
final float HIDE_THRESHOLD = 0;
final float RIGID_PARTICLE_SIZE = 10;
final color COLOR_1 = color(50, 30, 255);
final color COLOR_2 = color(204, 93, 255);
final color COLOR_3 = color(10, 40, 100);
final color COLOR_4 = color(255, 255, 255);

ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

void settings() {
  size(int(CONTAINER_WIDTH), int(CONTAINER_HEIGHT), P3D);
}

void setup() {
  wind = new PVector(0, 0);
  gravity = new PVector(0, GRAVITY);
  for (int i=0; i < NUM_PARTICLES; i++) {
    particleSystem.add(new Particle(random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH), random(20)));
  }
  List<RigidBodyParticle> cube = createRigidCube(8, 0, 0, 0);
  particleSystem.addAll(cube);
}

void draw() {
  background(0);
  noStroke();
  lights();
  wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.00005);
  particleSystem.update();
  particleSystem.render();
}
