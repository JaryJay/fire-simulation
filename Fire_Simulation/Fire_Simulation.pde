// ***************************************************
// * Fire Simulation - By Jay Ren                    *
// * Simulates fire using particle physics!          *
// ***************************************************

import g4p_controls.*;
import peasy.*;
import java.util.List;

// A bunch of constants
final int INITIAL_NUM_PARTICLES = 1500;

final float HEAT_DIFFUSION_RADIUS = 2;
final float HEAT_DIFFUSION_SPEED = 0.05;
final float CONTAINER_HEIGHT = 400;
final float CONTAINER_WIDTH = 400;
final float CONTAINER_LENGTH = 450;

final float UPWARD_FORCE = 0.038;

final float HIDE_THRESHOLD = 3;

final float RIGID_PARTICLE_SIZE = 20;

final color COLOR_1 = color(1, 1, 0);
final color COLOR_2 = color(204, 93, 2);
final color COLOR_3 = color(50, 40, 100);
final color COLOR_4 = color(255, 255, 255);

float particleSize = 7;
float sourceHeat = 2.4;
float burnHeat = 20;
int cubeSize = 4;

PeasyCam cam;
ParticleSystem particleSystem = new ParticleSystem();
PVector gravity = new PVector(0, 0.7);

void setup() {
  size(800, 800, P3D);
  // Set up PeasyCam for 3D camera movement
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);
  cam.setSuppressRollRotationMode();
  cam.setYawRotationMode();
  createGUI();
  
  for (int i=0; i < INITIAL_NUM_PARTICLES; i++) {
    particleSystem.add(generateParticle());
  }
  // Initial particles are really scattered, so we update
  // 20 times to make them cool down a little
  for (int i = 0; i < 20; i++) {
    particleSystem.update();
  }
  textSize(40);
  textAlign(CENTER);
}

void draw() {
  background(200, 200, 220);
  noStroke();
  synchronized (particleSystem) {
    particleSystem.update();
    particleSystem.render();
    numParticlesLabel.setText("Number of Particles:         " + particleSystem.particles.size());
  }
  
  // Show instructions for the first 5 seconds
  if (millis() < 5000) {
    cam.beginHUD();
    fill(255);
    text("Left-click and drag to rotate", width/2, 100);
    text("Scroll or right-click to zoom in/out", width/2, 150);
    text("Use the control panel to do cool things!", width/2, 250);
    cam.endHUD();
  }
}
