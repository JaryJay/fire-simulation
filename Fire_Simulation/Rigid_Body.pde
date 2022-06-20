// Represents a particle that is part of a rigid body (in this case, a cube)
class RigidBodyParticle extends Particle {

  ArrayList<RigidBodyParticle> bonds = new ArrayList<RigidBodyParticle>();

  RigidBodyParticle(float x, float y, float z) {
    super(x, y, z, 0);
  }

  void bondWith(RigidBodyParticle p) {
    bonds.add(p);
    p.bonds.add(this);
  }

  void unbondWith(RigidBodyParticle p) {
    bonds.remove(p);
    p.bonds.remove(this);
  }

  void unbondAll() {
    for (int i = bonds.size() - 1; i >= 0; i--) {
      unbondWith(bonds.get(i));
    }
  }
  
  // Rigid body particles have slightly different behaviours than normal ones
  
  @Override void updatePosition(float dt) {
    // Use Verlet integration to update the position
    PVector velocity = position.copy().sub(prevPosition);
    // Don't move as much along the XZ plane (it still moves the same amount in the Y axis)
    velocity = new PVector(velocity.x * 0.9, velocity.y, velocity.z * 0.9);
    prevPosition = position.copy();
    position.add(velocity).add(force.mult(dt * dt));
    force.set(0, 0);
  }
  
  @Override void updateHeat(float dt) {
    heat += heatChange + random(dt) - dt / 2;
    heatChange = 0;
    heat *= 0.999;
    heat = max(heat, 0);
  }

  @Override float radius() {
    return particleSize;
  }
  
  
  @Override void render() {
    fill(lerp(color(255), color(0), heat / burnHeat));
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
  }
  
}
