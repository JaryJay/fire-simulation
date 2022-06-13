class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>();

  void update() {
    int numSubsteps = 2;
    applyHeatDiffusion();
    for (int substep = 0; substep < numSubsteps; substep++) {
      float dt = 1.0 / numSubsteps;
      applyForces();
      applyCollisions();
      applyPositionChanges(dt);
      applyConstraints();
      applyHeatChanges(dt);
    }
  }

  void applyHeatDiffusion() {
    for (int i=0; i < particles.size(); i++) {
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p0 = particles.get(i);
        Particle p1 = particles.get(j);
        PVector pos0 = p0.position;
        PVector pos1 = p1.position;
        float dist = dist(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z); 
        if (dist < p0.radius() + p1.radius() + HEAT_DIFFUSION_RADIUS) {
          float heatDiff = abs(p1.heat - p0.heat);
          if (p1.heat < p0.heat) {
            p1.heat += heatDiff * 0.08;
            p0.heat -= heatDiff * 0.08;
          } else {
            p0.heat += heatDiff * 0.08;
            p1.heat -= heatDiff * 0.08;
          }
        }
      }
    }
  }

  void applyForces() {
    for (Particle p : particles) {
      p.force.add(wind);
      p.force.add(gravity);
      p.force.add(0, -p.heat * 0.04, 0);
    }
  }

  void applyCollisions() {
    for (int i=0; i < particles.size(); i++) {
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p0 = particles.get(i);
        Particle p1 = particles.get(j);
        handleCollision(p0, p1);
      }
    }
  }

  void applyConstraints() {
    for (Particle p : particles) {
      p.position.x = min(max(p.position.x, 0 + p.radius()), CONTAINER_WIDTH - p.radius());
      p.position.y = min(max(p.position.y, 0 + p.radius()), CONTAINER_HEIGHT - p.radius(), p.position.y);
      p.position.z = min(max(p.position.z, -CONTAINER_LENGTH + p.radius()), 0 - p.radius());
    }
  }

  void applyPositionChanges(float dt) {
    for (Particle p : particles) {
      p.updatePosition(dt);
    }
  }

  void applyHeatChanges(float dt) {
    for (Particle p : particles) {
      p.updateHeat(dt);
    }
  }


  void handleCollision(Particle p0, Particle p1) {
    PVector pos0 = p0.position;
    PVector pos1 = p1.position;
    float dist = dist(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z); 
    if (dist < p0.radius() + p1.radius()) {
      float moveFactor0 = 0.5   *   (p0.radius() + p1.radius() - dist);
      float moveFactor1 = 0.5   *   (p0.radius() + p1.radius() - dist);
      PVector pos1ToPos0 = pos0.copy().sub(pos1).normalize(); 
      pos0.add( pos1ToPos0.copy().mult( moveFactor0) );
      pos1.add( pos1ToPos0.copy().mult(-moveFactor1) );
    }
  }


  void render() {
    for (Particle p : particles) {
      p.render();
    }
  }
}
