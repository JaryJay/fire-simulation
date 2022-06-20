color lerp(color c1, color c2, float factor) {
  float r1 = red(c1), g1 = green(c1), b1 = blue(c1);
  float r2 = red(c2), g2 = green(c2), b2 = blue(c2);
  
  return color((r2 - r1) * factor + r1, (g2 - g1) * factor + g1, (b2 - b1) * factor + b1);
}

Particle generateParticle() {
  Particle p = new Particle(random(CONTAINER_WIDTH) - CONTAINER_WIDTH / 2, random(CONTAINER_HEIGHT) - CONTAINER_HEIGHT / 2, random(CONTAINER_LENGTH) - CONTAINER_LENGTH / 2, 10);
  return p;
}

ArrayList<RigidBodyParticle> createRigidStick(int l, float x, float y, float z) {
  ArrayList<RigidBodyParticle> list = new ArrayList<RigidBodyParticle>();
  list.add(new RigidBodyParticle(x, y, z));
  for (int i=1; i < l; i++) {
    RigidBodyParticle p = new RigidBodyParticle(x + i * list.get(0).radius(), y, z);
    p.bondWith(list.get(i-1));
    list.add(p);
  }
  return list;
}

List<RigidBodyParticle> createRigidCube(int size, float x, float y, float z) {
  List<List<List<RigidBodyParticle>>> cube = new ArrayList<List<List<RigidBodyParticle>>>();
  for (int r = 0; r < size; r++) {
    cube.add(new ArrayList<List<RigidBodyParticle>>());
    for (int c = 0; c < size; c++) {
      cube.get(r).add(new ArrayList<RigidBodyParticle>());
      for (int d = 0; d < size; d++) {
        RigidBodyParticle p = new RigidBodyParticle(x + r * RIGID_PARTICLE_SIZE, y + c * RIGID_PARTICLE_SIZE, z + d * RIGID_PARTICLE_SIZE);
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
