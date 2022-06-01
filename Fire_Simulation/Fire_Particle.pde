class FireParticle {
  PVector position;
  PVector force;
  PVector velocity;
  float heat = 10;
  
  void update() {
    velocity.add(force);
    velocity.mult(0.98);
    position.add(velocity);
  }
  
  void render() {
    fill(0);
    ellipse(position.x, position.y, heat, heat);
  }
}
