color lerp(color c1, color c2, float factor) {
  float r1 = red(c1), g1 = green(c1), b1 = blue(c1);
  float r2 = red(c2), g2 = green(c2), b2 = blue(c2);
  
  return color((r2 - r1) * factor + r1, (g2 - g1) * factor + g1, (b2 - b1) * factor + b1);
}
