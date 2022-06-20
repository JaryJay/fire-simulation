// Most of the function names are self-explanatory

color lerp(color c1, color c2, float factor) {
  float r1 = red(c1), g1 = green(c1), b1 = blue(c1);
  float r2 = red(c2), g2 = green(c2), b2 = blue(c2);
  
  return color((r2 - r1) * factor + r1, (g2 - g1) * factor + g1, (b2 - b1) * factor + b1);
}

Particle generateParticle() {
  Particle p = new Particle(random(CONTAINER_WIDTH) - CONTAINER_WIDTH / 2, random(CONTAINER_HEIGHT) - CONTAINER_HEIGHT / 2, random(CONTAINER_LENGTH) - CONTAINER_LENGTH / 2, 10);
  return p;
}

List<RigidBodyParticle> createRigidCube(int size, float x, float y, float z) {
  // 3D list of rigid body particles
  List<List<List<RigidBodyParticle>>> cube = new ArrayList<List<List<RigidBodyParticle>>>();
  for (int r = 0; r < size; r++) {
    cube.add(new ArrayList<List<RigidBodyParticle>>());
    for (int c = 0; c < size; c++) {
      cube.get(r).add(new ArrayList<RigidBodyParticle>());
      for (int d = 0; d < size; d++) {
        RigidBodyParticle p = new RigidBodyParticle(x + r * particleSize * 2, y + c * particleSize * 2, z + d * particleSize * 2);
        // Bond with 3 other particles
        if (r != 0) {
          p.bondWith(cube.get(r - 1).get(c).get(d));
        }
        if (c != 0) {
          p.bondWith(cube.get(r).get(c - 1).get(d));
        }
        if (d != 0) {
          p.bondWith(cube.get(r).get(c).get(d - 1));
        }
        cube.get(r).get(c).add(p);
      }
    }
  }
  List<RigidBodyParticle> finalList = new ArrayList<RigidBodyParticle>();
  for (int r = 0; r < size; r++) {
    for (int c = 0; c < size; c++) {
      for (int d = 0; d < size; d++) {
        finalList.add(cube.get(r).get(c).get(d));
      }
    }
  }
  return finalList;
}
