class Particle {
	PVector position;
	PVector prevPosition;
	PVector force;
	float heat;

	Particle(float x, float y, float z, float heat) {
		this.position = new PVector(x, y, z);
		this.prevPosition = new PVector(x, y, z);
		this.force = new PVector();
		this.heat = heat;
	}
	
	void updatePosition() {
		// Use Verlet integration to update the position
		PVector velocity = position.copy().sub(prevPosition);
    velocity.mult(0.95);
		prevPosition = position.copy();
		//force.mult(0.95);
		position.add(velocity).add(force);
		// Reset the force
		force.set(0, 0);
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
