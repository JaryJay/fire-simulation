class FireParticle {
	PVector position;
	PVector prevPosition;
	PVector force;
	float heat;

	FireParticle(float x, float y, float heat) {
		this.position = new PVector(x, y);
		this.prevPosition = new PVector(x, y);
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
		if (position.y > height - heat) {
			position.y = height - heat;
		}
	}
	
	void render() {
		fill(0);
		ellipse(position.x, position.y, radius() * 2, radius() * 2);
	}

	float radius() {
		return heat * 0.9 + 5;
	}
}
