class RigidBodyParticle extends Particle {

  ArrayList<RigidBodyParticle> bonds = new ArrayList<RigidBodyParticle>();

  RigidBodyParticle(float x, float y, float z) {
    super(x, y, z, 0);
  }

  void bondWith(RigidBodyParticle p) {
    bonds.add(p);
    p.bonds.add(p);
  }

  void unbondWith(RigidBodyParticle p) {
    bonds.remove(p);
    p.bonds.remove(p);
  }

  void unbondAll() {
    for (int i = bonds.size() - 1; i >= 0; i--) {
      unbondWith(bonds.get(i));
    }
  }

  @Override float radius() {
    return RIGID_PARTICLE_SIZE / 2;
  }
  
  
  void render() {
    //if (heat < HIDE_THRESHOLD) {
    //  return;
    //}
    //if (heat < 10) {
    //  fill(lerp(COLOR_1, COLOR_2, (heat - HIDE_THRESHOLD) / (10 - HIDE_THRESHOLD)));
    //} else if (heat < 25) {
    //  fill(lerp(COLOR_2, COLOR_3, (heat - 10) / (25 - 10)));
    //} else if (heat < 60) {
    //  fill(lerp(COLOR_3, COLOR_4, (heat - 25) / (60 - 25)));
    //}
    fill(255,255,255);
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
  }
  
}
