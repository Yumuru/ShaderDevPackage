#ifndef DistanceFunction
#define DistanceFunction

float sdSphere(float3 p, float s) {
  return length(p) - s;
}

float sdBox(float3 p, float3 b) {
  float3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

float sdTorus(float3 p, float2 t) {
  float2 q = float2(length(p.xz) - t.x, p.y);
  return length(q) - t.y;
}

float sdCylinder(float3 p, float3 c) {
  return length(p.xz - c.xy) - c.z;
}

float sdCappedCylinder(float3 p, float h, float r) {
  float2 d = abs(float2(length(p.xz), p.y)) - float2(h, r);
  return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}

float sdPlane(float3 p, float4 n) {
  return dot(p, n.xyz) + n.w;
}

float sdOctahedron(float3 p, float s) {
  p = abs(p);
  float m = p.x+p.y+p.z-s;
  float3 q;
       if( 3.0*p.x < m ) q = p.xyz;
  else if( 3.0*p.y < m ) q = p.yzx;
  else if( 3.0*p.z < m ) q = p.zxy;
  else return m*0.57735027;
    
  float k = clamp(0.5*(q.z-q.y+s),0.0,s); 
  return length(float3(q.x,q.y-s+k,q.z-k)); 
}

float opUnion(float d1, float d2) {
  return min(d1, d2);
}

float opSubtraction(float d1, float d2) {
  return max(-d1,d2);
}

float opIntersection(float d1, float d2) {
  return max(d1, d2);
}

float opSmoothUnion(float d1, float d2, float k) {
  float h = clamp(0.5 + 0.5 * (d2 - d1) / k, 0.0, 1.0);
  return lerp(d2, d1, h) - k*h*(1.0-h);
}

#endif
