import java.util.List;

final int NUM_PARTICLES = 1800;

final float HEAT_DIFFUSION_RADIUS = 2;
final float HEAT_DIFFUSION_SPEED = 0.2;
final float CONTAINER_HEIGHT = 600;
final float CONTAINER_WIDTH = 600;
final float CONTAINER_LENGTH = 450;

final float GRAVITY = 0.7;
final float UPWARD_FORCE = 0.038;

final float HIDE_THRESHOLD = 5;

final float PARTICLE_SIZE = 7;
final float RIGID_PARTICLE_SIZE = 20;

final float BURN_HEAT = 60;

final color COLOR_1 = color(1, 1, 0);
final color COLOR_2 = color(204, 93, 2);
final color COLOR_3 = color(50, 40, 100);
final color COLOR_4 = color(255, 255, 255);

ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

void settings() {
  size(int(CONTAINER_WIDTH), int(CONTAINER_HEIGHT), P3D);
}

void setup() {
  //frameRate(5);
  wind = new PVector(0, 0);
  gravity = new PVector(0, GRAVITY);
  for (int i=0; i < NUM_PARTICLES; i++) {
    particleSystem.add(new Particle(random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH), random(20)));
  }
  for (int i = 0; i < 2; i ++) {
    List<RigidBodyParticle> cube = createRigidCube(6, random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH));
    particleSystem.addAll(cube);
  }
  for (int i = 0; i < 20; i++) {
    particleSystem.update();
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
