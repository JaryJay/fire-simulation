color lerp(color c1, color c2, float factor) {
  float r1 = red(c1), g1 = green(c1), b1 = blue(c1);
  float r2 = red(c2), g2 = green(c2), b2 = blue(c2);
  
  return color((r2 - r1) * factor + r1, (g2 - g1) * factor + g1, (b2 - b1) * factor + b1);
}

ArrayList<RigidBodyParticle> createRigidStick(int l, float x, float y, float z) {
  ArrayList<RigidBodyParticle> list = new ArrayList<RigidBodyParticle>();
  list.add(new RigidBodyParticle(x, y, z, 0));
  for (int i=1; i < l; i++) {
    RigidBodyParticle p = new RigidBodyParticle(x + i * list.get(0).radius(), y, z, 0);
    p.bondWith(list.get(i-1));
    list.add(p);
  }
  return list;
}
