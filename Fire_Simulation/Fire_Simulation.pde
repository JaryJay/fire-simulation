import g4p_controls.*;
import peasy.*;
import java.util.List;

final int NUM_PARTICLES = 1000;

final float HEAT_DIFFUSION_RADIUS = 2;
final float HEAT_DIFFUSION_SPEED = 0.05;
final float CONTAINER_HEIGHT = 400;
final float CONTAINER_WIDTH = 400;
final float CONTAINER_LENGTH = 450;

final float GRAVITY = 0.7;
final float UPWARD_FORCE = 0.038;

final float HIDE_THRESHOLD = 3;

final float PARTICLE_SIZE = 7;
final float RIGID_PARTICLE_SIZE = 20;

final float BURN_HEAT = 20;

final color COLOR_1 = color(1, 1, 0);
final color COLOR_2 = color(204, 93, 2);
final color COLOR_3 = color(50, 40, 100);
final color COLOR_4 = color(255, 255, 255);

ParticleSystem particleSystem = new ParticleSystem();
PVector wind;
PVector gravity;

PeasyCam cam;

void settings() {
  size(int(800), int(800), P3D);
}

void setup() {
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);
  cam.setYawRotationMode();
  
  createGUI();
  
  wind = new PVector(0, 0);
  gravity = new PVector(0, GRAVITY);
  for (int i=0; i < NUM_PARTICLES; i++) {
    particleSystem.add(new Particle(random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH), random(20)));
  }
  for (int i = 0; i < 20; i++) {
    particleSystem.update();
  }
  for (int i = 0; i < 5; i ++) {
    List<RigidBodyParticle> cube = createRigidCube(4, random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH));
    particleSystem.addAll(cube);
  }
}

void draw() {
  background(200, 200, 200);
  noStroke();
  //lights();
  //wind = new PVector(mouseX - width/2, mouseY - height/2).mult(0.0005);
  particleSystem.update();
  particleSystem.render();
}

void keyPressed() {
  if (key == 'c') {
    List<RigidBodyParticle> cube = createRigidCube(4, random(CONTAINER_WIDTH), random(CONTAINER_HEIGHT), random(CONTAINER_LENGTH));
    particleSystem.addAll(cube);
  }
}
