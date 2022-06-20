class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<RigidBodyParticle> rigidBodyParticles = new ArrayList<RigidBodyParticle>();

  void update() {
    int numSubsteps = 2;
    applyHeatDiffusion();
    for (int substep = 0; substep < numSubsteps; substep++) {
      float dt = 1.0 / numSubsteps;
      applyForces();
      applyCollisions();
      applyPositionChanges(dt);
      applyConstraints();
      applyRigidBodyConstraints();
      applyHeatChanges(dt);
    }
    convertHotRigidBodies();
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
            p1.heat += heatDiff * HEAT_DIFFUSION_SPEED;
            p0.heat -= heatDiff * HEAT_DIFFUSION_SPEED;
          } else {
            p0.heat += heatDiff * HEAT_DIFFUSION_SPEED;
            p1.heat -= heatDiff * HEAT_DIFFUSION_SPEED;
          }
        }
      }
    }
  }

  void applyForces() {
    for (Particle p : particles) {
      p.force.add(gravity);
      if (gravity.y != 0 && !(p instanceof RigidBodyParticle)) {
        p.force.add(0, p.heat * -UPWARD_FORCE, 0);
      }
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
      p.position.x = min(max(p.position.x, -CONTAINER_WIDTH / 2 + p.radius()), CONTAINER_WIDTH / 2 - p.radius());
      p.position.y = min(max(p.position.y, -CONTAINER_HEIGHT / 2 - 500 + p.radius()), CONTAINER_HEIGHT / 2 - p.radius());
      p.position.z = min(max(p.position.z, -CONTAINER_LENGTH / 2 + p.radius()), CONTAINER_LENGTH / 2 - p.radius());
    }
  }

  void applyPositionChanges(float dt) {
    for (Particle p : particles) {
      p.updatePosition(dt);
    }
  }

  void applyRigidBodyConstraints() {
    for (RigidBodyParticle p0 : rigidBodyParticles) {
      for (RigidBodyParticle p1 : p0.bonds) {
        PVector pos0 = p0.position;
        PVector pos1 = p1.position;
        float dist = dist(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z);
        if (dist > p0.radius() + p1.radius()) {
          float moveFactor0 = 0.3   *   (dist - p0.radius() - p1.radius());
          float moveFactor1 = 0.3   *   (dist - p0.radius() - p1.radius());
          PVector p1ToP0 = p0.position.copy().sub(p1.position).normalize();
          p1.position.add(p1ToP0.copy().mult( moveFactor1));
          p0.position.add(p1ToP0.copy().mult(-moveFactor0));
        }
      }
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
  
  void convertHotRigidBodies() {
    for (int i = rigidBodyParticles.size() - 1; i >= 0; i--) {
      RigidBodyParticle p = rigidBodyParticles.get(i);
      if (p.heat >= burnHeat) {
        rigidBodyParticles.remove(i);
        particles.remove(p);
        p.unbondAll();
        particles.add(new Particle(p.position.x, p.position.y, p.position.z, 0));
      }
    }
  }


  void render() {
    for (Particle p : particles) {
      p.render();
    }
  }

  void add(Particle p) {
    particles.add(p);
    if (p instanceof RigidBodyParticle) {
      rigidBodyParticles.add((RigidBodyParticle) p);
    }
  }

  void addAll(List<RigidBodyParticle> particles) {
    for (RigidBodyParticle p : particles) {
      add(p);
    }
  }
  
  void removeNParticles(int n) {
    n = min(max(0, n), particles.size());
    for (int i = 0; i < n; i++) {
      int removeIndex = int(random(particles.size()));
      Particle particle = particles.remove(removeIndex);
      if (particle instanceof RigidBodyParticle) {
        // Extra actions if we remove a rigid body particle
        ((RigidBodyParticle) particle).unbondAll();
        rigidBodyParticles.remove(particle);
      }
    }
  }
  
}
