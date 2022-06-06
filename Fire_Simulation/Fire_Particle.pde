class FireParticle {
	PVector position;
	PVector prevPosition;
	PVector force;
	float heat;

	FireParticle(float x, float y, float z, float heat) {
		this.position = new PVector(x, y, z);
		this.prevPosition = new PVector(x, y, z);
		this.force = new PVector();
		this.heat = heat;
	}
	
	void update(PVector wind, PVector gravity) {
		// Use Verlet integration to update the position
		PVector velocity = position.copy().sub(prevPosition);
		prevPosition = position.copy();
		force.add(gravity).add(wind);
		force.mult(0.95);
		position.add(velocity).add(force);
		// Reset the force
		force.set(0, 0);
		if (position.y > 500 - heat) {
			position.y = 500 - heat;
		}
	}
	
	void render() {
		fill(255);
    translate(position.x, position.y, position.z);
    box(radius());
    translate(-position.x, -position.y, -position.z);
	}

	float radius() {
		return heat * 0.9 + 5;
	}
}
