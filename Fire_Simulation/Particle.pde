// Represents a fiery particle.
class Particle {
  PVector position;
  PVector prevPosition;
  PVector force;
  float heat;
  float heatChange = 0;

  Particle(float x, float y, float z, float heat) {
    this.position = new PVector(x, y, z);
    this.prevPosition = new PVector(x, y, z);
    this.force = gravity.copy();
    this.heat = heat;
  }

  void updatePosition(float dt) {
    // Use Verlet integration to update the position
    PVector velocity = position.copy().sub(prevPosition);
    velocity.mult(0.999);
    prevPosition = position.copy();
    //force.mult(0.95);
    position.add(velocity).add(force.mult(dt * dt));
    // Reset the force
    force.set(0, 0);
  }

  void updateHeat(float dt) {
    heat += heatChange + random(dt) - dt / 2;
    heatChange = 0;
    if (position.y < -CONTAINER_HEIGHT / 2) {
      // Heat dissipates faster when it's high up in the air
      heat *= 0.95;
    } else {
      heat *= 0.996;
    }
    // Increase heat if close to the bottom of the container
    if (position.y + radius() >= CONTAINER_HEIGHT / 2 - 50) {
      heat += random(dt) * sourceHeat;
    }
    heat = max(heat, 0);
  }

  void render() {
    if (heat < HIDE_THRESHOLD) {
      return;
    }
    // The heat is used to interpolate between different colors, making a cool gradient effect
    if (heat < 10) {
      fill(lerp(COLOR_1, COLOR_2, (heat) / (10)));
    } else if (heat < 25) {
      fill(lerp(COLOR_2, COLOR_3, (heat - 10) / (25 - 10)));
    } else if (heat < 60) {
      fill(lerp(COLOR_3, COLOR_4, (heat - 25) / (60 - 25)));
    } else {
      fill(COLOR_4);
    }
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
  }

  // The radius is a function of the heat and the particle size
  float radius() {
    return 1.8 * sqrt(heat) + particleSize;
  }
}
