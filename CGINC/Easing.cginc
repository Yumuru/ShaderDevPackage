// https://easings.net/ja
// https://github.com/ai/easings.net/blob/master/src/easings/easingsFunctions.ts

#ifndef Easing
#define Easing

#define PI UNITY_PI

float2 divRange(float x, float d, float p) {
  float2 r = float2(saturate(x * d / p), saturate((x * d - p) / (d - p)));
  r.x = lerp(r.x, 0, r.y > 0);
  return r;
}

float inOutSine(float x) {
  return (1-cos(x*PI)) / 2;
}

float outSine(float x) {
  return sin((x * PI) / 2);
}

float inQuad(float x) {
  return x * x;
}

float outQuad(float x) {
  return 1 - (1 - x) * (1 - x);
}

float inCubic(float x) {
  return x * x * x;
}

float outCubic(float x) {
  return 1 - pow(1 - x, 3);
}

float inOutCubic(float x) {
  return lerp(1 - pow(-2 * x + 2, 3) / 2, 4 * x * x * x, x < 0.5);
}

float inQuart(float x) {
  return x * x * x * x;
}

float inOutQuart(float x) {
  return lerp(1 - pow(-2 * x + 2, 4) / 2, 8 * x * x * x * x, x < 0.5);
}

float inQuint(float x) {
  return x * x * x * x * x;
}

float outQuint(float x) {
  return 1 - pow(1 - x, 5);
}

float inOutQuint(float x) {
  return lerp(1 - pow(-2 * x + 2, 5) / 2, 16 * x * x * x * x * x, x < 0.5);
}

float inExpo(float x) {
  return lerp(0, pow(2, 10 * x - 10), x != 0);
}

#endif
