#ifndef Memory_CGINC
#define Memory_CGINC

struct Memory {
  uint resolution;
  sampler2D memory;
  uint id;
};

Memory newMemory(uint resolution, sampler2D memory) {
  Memory m;
  m.resolution = resolution;
  m.memory = memory;
  m.id = 0;
  return m;
}

uint memid(inout Memory m, float2 uv) {
  return floor(uv.x * m.resolution) + floor(m.resolution * uv.y) * m.resolution;
}
float2 muv(inout Memory m, uint id) {
  return float2(id % m.resolution + 0.5, id / m.resolution + 0.5) / m.resolution;
}
float4 mem(inout Memory m, uint id) {
  float2 uv = muv(m, id);
  return tex2Dlod(m.memory, float4(uv, 0, 0));
}
uint memui(inout Memory m, uint id) {
  uint4 o = mem(m, id) * 255.;
  return (o.x << 24) + (o.y << 16) + (o.z << 8) + (o.w << 0);
}
bool memb(inout Memory m, uint id) {
  return memui(m, id);
}
uint memi(inout Memory m, uint id) {
  return asint(memui(m, id));
}
float memf(inout Memory m, uint id) {
  return asfloat(memui(m, id));
}
float2 memf2(inout Memory m, uint id) {
  return float2(memf(m, id), memf(m, id+1));
}
float3 memf3(inout Memory m, uint id) {
  return float3(memf(m, id), memf(m, id+1), memf(m, id+2));
}
float3x3 memf3x3(inout Memory m, uint id) {
  return float3x3(memf3(m, id), memf3(m, id+3), memf3(m, id+6));
}
float4 memf4(inout Memory m, uint id) {
  return float4(memf(m, id), memf(m, id+1), memf(m, id+2), memf(m, id+3));
}
float4x4 memf4x4(inout Memory m, uint id) {
  return float4x4(memf4(m, id), memf4(m, id+4), memf4(m, id+8), memf4(m, id+16));
}

uint newMVal(inout uint id, uint size) {
  return (id += size) - size;
}


float4 tom(bool v) {
  return (uint(v));
}
float4 tom(uint v) {
  return float4(
    ((v >> 24) & 0xff) / 255.,
    ((v >> 16) & 0xff) / 255.,
    ((v >>  8) & 0xff) / 255.,
    ((v >>  0) & 0xff) / 255.);
}
float4 tom(int v) {
  return tom(asuint(v));
}
float4 tom(float v) {
  return tom(asuint(v));
}

#define Assign(mem, id, val) mem[id] = tom(val);
#define Assignfloat2(mem, id, val) \
  mem[id + 0] = tom(val.x); \
  mem[id + 1] = tom(val.y);
#define Assignfloat3(mem, id, val) \
  mem[id + 0] = tom(val.x); \
  mem[id + 1] = tom(val.y); \
  mem[id + 2] = tom(val.z);
#define Assignfloat3x3(mem, id, val) \
  Assignfloat3(mem, id + 0, val[0]); \
  Assignfloat3(mem, id + 3, val[1]); \
  Assignfloat3(mem, id + 6, val[2]);
#define Assignfloat4(mem, id, val) \
  mem[id + 0] = tom(val.x); \
  mem[id + 1] = tom(val.y); \
  mem[id + 2] = tom(val.z); \
  mem[id + 3] = tom(val.w)
#define Assignfloat4x4(mem, id, val) \
  Assignfloat4(mem, id +  0, val[0]); \
  Assignfloat4(mem, id +  4, val[1]); \
  Assignfloat4(mem, id +  8, val[2]); \
  Assignfloat4(mem, id + 12, val[3])


#endif
