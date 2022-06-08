class Particle {
	PVector position;
	PVector prevPosition;
	PVector force;
	float heat;
  float heatChange = 0;
  float prevHeat;

	Particle(float x, float y, float z, float heat) {
		this.position = new PVector(x, y, z);
		this.prevPosition = new PVector(x, y, z);
		this.force = new PVector();
		this.heat = heat;
    this.prevHeat = heat;
	}
	
	void updatePosition() {
		// Use Verlet integration to update the position
		PVector velocity = position.copy().sub(prevPosition);
    velocity.mult(0.99);
		prevPosition = position.copy();
		//force.mult(0.95);
		position.add(velocity).add(force);
		// Reset the force
		force.set(0, 0);
	}

  void updateHeat() {
    heat += heatChange + random(2) - 1;
    heatChange = 0;
    heat *= 0.99;
    heat = min(max(heat, 0), 500);
    prevHeat = heat;
  }
	
	void render() {
    if (heat < 5) {
      fill(lerp(color(0, 0, 0), color(204, 93, 2), heat / 5));
    } else if (heat < 25) {
      fill(lerp(color(204, 93, 2), color(255, 72, 43), (heat - 5) / (25 - 5)));
    } else if (heat < 100) {
      fill(lerp(color(255, 72, 43), color(255, 255, 255), (heat - 25) / (100 - 10)));
    }
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
	}

	float radius() {
		return heat + 5;
	}
}
