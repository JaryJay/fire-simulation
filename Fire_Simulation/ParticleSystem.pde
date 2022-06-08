class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>();

  void update() {
    for (int i=0; i < particles.size(); i++) {
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p0 = particles.get(i);
        Particle p1 = particles.get(j);
        handleHeatDiffusion(p0, p1);
      }
    }
    for (Particle p : particles) {
      p.force.add(wind);
      p.force.add(gravity);
      p.force.add(0, -p.heat * 0.05,0);
    }
    for (int i=0; i < particles.size(); i++) {
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p0 = particles.get(i);
        Particle p1 = particles.get(j);
        handleCollision(p0, p1);
      }
    }
    for (Particle p : particles) {
      p.position.y = min(600 - p.radius(), p.position.y);
      p.position.x = min(max(p.position.x, 0 + p.radius()), CONTAINER_WIDTH - p.radius());
      p.position.z = min(max(p.position.z, -CONTAINER_LENGTH + p.radius()), 0 - p.radius());
    }
    for (Particle p : particles) {
      p.updatePosition();
    }
    for (Particle p : particles) {
      p.updateHeat();
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

  void handleHeatDiffusion(Particle p0, Particle p1) {
    PVector pos0 = p0.position;
    PVector pos1 = p1.position;
    float dist = dist(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z); 
    if (dist < p0.radius() + p1.radius() + HEAT_DIFFUSION_RADIUS) {
      float heatDiff = abs(p1.heat - p0.heat);
      if (p1.heat < p0.heat) {
        p1.heat += heatDiff * 0.03;
        p0.heat -= heatDiff * 0.03;
      } else {
        p0.heat += heatDiff * 0.03;
        p1.heat -= heatDiff * 0.03;
      }
    }
  }

  void render() {
    for (Particle p : particles) {
      p.render();
    }
  }
}
