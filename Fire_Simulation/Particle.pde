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
	
	void updatePosition(float dt) {
		// Use Verlet integration to update the position
		PVector velocity = position.copy().sub(prevPosition);
    //velocity.mult(0.999);
		prevPosition = position.copy();
		//force.mult(0.95);
		position.add(velocity).add(force.mult(dt * dt));
		// Reset the force
		force.set(0, 0);
	}

  void updateHeat(float dt) {
    heat += heatChange + random(dt) - dt / 2;
    heatChange = 0;
    heat *= 0.99;
    heat = min(max(heat, 0), 500);
    prevHeat = heat;
    if (position.y + radius() >= CONTAINER_HEIGHT) {
      heat += random(1);
    }
  }
	
	void render() {
    if (heat < 10) {
      fill(lerp(color(1, 1, 1), color(204, 93, 2), heat / 10));
    } else if (heat < 25) {
      fill(lerp(color(204, 93, 2), color(40,10,100), (heat - 10) / (25 - 10)));
    } else if (heat < 60) {
      fill(lerp(color(40,10,100), color(255, 255, 255), (heat - 25) / (60 - 25)));
    }
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
	}

	float radius() {
		return 1.5 * sqrt(heat) + 6;
	}
}
