class RigidBodyParticle extends Particle {

  ArrayList<RigidBodyParticle> bonds = new ArrayList<RigidBodyParticle>();

  RigidBodyParticle(float x, float y, float z, float heat) {
    super(x, y, z, heat);
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

  @Override
    float radius() {
    return 6;
  }
}
