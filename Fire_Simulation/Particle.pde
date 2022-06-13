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
    if (heat < HIDE_THRESHOLD) {
      return;
    }
    if (heat < 10) {
      fill(lerp(COLOR_1, COLOR_2, heat / 10));
    } else if (heat < 25) {
      fill(lerp(COLOR_2, COLOR_3, (heat - 10) / (25 - 10)));
    } else if (heat < 60) {
      fill(lerp(COLOR_3, COLOR_4, (heat - 25) / (60 - 25)));
    }
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
	}

	float radius() {
		return 1.5 * sqrt(heat) + 6;
	}
}
