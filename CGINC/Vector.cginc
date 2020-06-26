#ifndef Vector
#define Vector

#define PI UNITY_PI
#define Deg2Rad ((PI * 2.0) / 360.0)

float3x3 rotate(float angle, float3 axis) {
  float3 a = normalize(axis);
  float s = sin(angle);
  float c = cos(angle);
  float r = 1.0 - c;
  float3x3 m = float3x3(
    a.x * a.x * r + c, a.y * a.x * r + a.z * s, a.z * a.x * r - a.y * s,
    a.x * a.y * r - a.z * s, a.y * a.y * r + c, a.z * a.y * r + a.x * s,
    a.x * a.z * r + a.y * s, a.y * a.z * r - a.x * s, a.z * a.z  * r + c
  );
  return m;
}

float3x3 rotateDeg(float angle, float3 axis) { return rotate(Deg2Rad * angle, axis); }

#define rotateFromRate(maxAngle, rate, axis) \
  rotate(Deg2Rad * maxAngle * rate, axis)

float3x3 rotate360(float rate, float3 axis) {
  return rotateFromRate(360, rate, axis);
}

float3x3 lookAt(float3 dir, float3 up) {
  float3 xaxis = normalize(cross(up, dir));
  float3 yaxis = normalize(cross(dir, xaxis));
  float3x3 m = float3x3(
    xaxis.x, yaxis.x, dir.x,
    xaxis.y, yaxis.y, dir.y,
    xaxis.z, yaxis.z, dir.z
  );
  return m;
}

#endif
