// Collatz Conjecture based on Edmund Harris visualization rules
// Processing 4.0

void setup() {

  size(800, 800);
  float rad = 0.08;
  int length = 7;
  int thickness = 1;
  int[] baseColor = {235, 0, 132};

  for (int i = 10000; i > 0; i--) {

    resetMatrix();
    translate(width/2, height-50);
    rotate(-radians(120.0));

    int currentNumber = i;
    int[] randomTone = generateRandomTone(baseColor[0],baseColor[1], baseColor[2]);
    strokeWeight(thickness);
    stroke(randomTone[0], randomTone[1], randomTone[2]);
    
    IntList collatzProgression = new IntList();

    do {
      currentNumber = collatz(currentNumber);
      collatzProgression.append(currentNumber);
    } while (currentNumber != 1);
    
    collatzProgression.reverse();
    
    for(int j=0; j<collatzProgression.size()-1; j++) {
     
      int actualNumber = collatzProgression.get(j);
      int nextNumber = collatzProgression.get(j+1);
      rotation(actualNumber, nextNumber, rad);
      buildTree(length);
      
    }
  }
}

int collatz(int n) {
  if (n % 2 == 0) {
    return n / 2;
  } else {
    return ((3*n + 1)/2);
  }
}

void rotation(int result, int next, float radians) {
if (next/result == 2 ) {
    rotate(radians*2);
  } else {
    rotate(-radians);
  }
}

void buildTree(int lineLength) {
  line(0, 0, 0, -lineLength);
  translate(0, -lineLength);
}

int[] generateRandomTone(int red, int green, int blue) {

  float randomLuminousity=random(0.15, 0.90);
  float[] customHslColor = rgbToHsl(red, green, blue);
  int[] customRGBtone = hslToRgb(customHslColor[0], customHslColor[1], randomLuminousity);

  return customRGBtone;
}

int[] hslToRgb(float h, float s, float l) {
  float r, g, b;

  if (s == 0f) {
    r = g = b = l; // achromatic
  } else {
    float q = l < 0.5f ? l * (1 + s) : l + s - l * s;
    float p = 2 * l - q;
    r = hueToRgb(p, q, h + 1f/3f);
    g = hueToRgb(p, q, h);
    b = hueToRgb(p, q, h - 1f/3f);
  }
  int[] rgb = {to255(r), to255(g), to255(b)};
  return rgb;
}

int to255(float v) {
  return (int)min(255, 256*v);
}

float hueToRgb(float p, float q, float t) {
  if (t < 0f)
    t += 1f;
  if (t > 1f)
    t -= 1f;
  if (t < 1f/6f)
    return p + (q - p) * 6f * t;
  if (t < 1f/2f)
    return q;
  if (t < 2f/3f)
    return p + (q - p) * (2f/3f - t) * 6f;
  return p;
}

float[] rgbToHsl(int pR, int pG, int pB) {
  float r = pR / 255f;
  float g = pG / 255f;
  float b = pB / 255f;

  float max = (r > g && r > b) ? r : (g > b) ? g : b;
  float min = (r < g && r < b) ? r : (g < b) ? g : b;

  float h, s, l;
  l = (max + min) / 2.0f;

  if (max == min) {
    h = s = 0.0f;
  } else {
    float d = max - min;
    s = (l > 0.5f) ? d / (2.0f - max - min) : d / (max + min);

    if (r > g && r > b)
      h = (g - b) / d + (g < b ? 6.0f : 0.0f);

    else if (g > b)
      h = (b - r) / d + 2.0f;

    else
      h = (r - g) / d + 4.0f;

    h /= 6.0f;
  }

  float[] hsl = {h, s, l};
  return hsl;
}
