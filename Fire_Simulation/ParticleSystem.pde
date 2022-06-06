class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>();

  void update() {
    for (int i=0; i < particles.size(); i++) {
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p0 = particles.get(i);
        Particle p1 = particles.get(j);
        PVector pos0 = p0.position;
        PVector pos1 = p1.position;
        float dist = dist(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z); 
        if (dist < p0.radius() + p1.radius()) {
          float moveFactor = (p0.radius() + p1.radius() - dist) / 2;
          PVector pos1ToPos0 = pos1.copy().sub(pos0).normalize(); 
          pos0.add( pos1ToPos0.mult( moveFactor) );
          pos1.add( pos1ToPos0.mult(-moveFactor) );
        }
      }
    }
    for (Particle p : particles) {
      p.update(wind, gravity);
    }
  }
  
  void render() {
    for (Particle p : particles) {
      p.render();
    }
  }
  
}
