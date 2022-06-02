ArrayList<FireParticle> particles = new ArrayList<FireParticle>();
PVector wind;
PVector gravity;

void setup() {
	size(800, 600);
	// frameRate(1);
	wind = new PVector(0, 0);
	gravity = new PVector(0, 0.2);
	particles.add(new FireParticle(200, 200, 10));
}

void draw() {
	background(255, 255, 255);
	for (FireParticle p : particles) {
		p.update(wind, gravity);
		p.render();
	}
}
