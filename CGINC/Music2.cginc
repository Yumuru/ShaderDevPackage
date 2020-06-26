#ifndef Music
#define Music

#define BPM 160
#define BarNum 64
static float timePerBeat = 60.0 / BPM;
static float timePerUnit = timePerBeat / 4.0;

float3 barToTiming(float bar) {
  float beat = frac(bar) * 4;
  float unit = frac(beat) * 4;
  return float3(floor(bar), floor(beat), unit);
}

float3 toTiming(float unit) {
  return float3(floor(unit / 4 / 4), floor(unit / 4 % 4), unit % 4);
}

float toUnit(float3 timing) {
  return timing.x * 4 * 4 + timing.y * 4 + timing.z;
}

float unitFromMusicPos(float musicPos) {
  return toUnit(barToTiming(musicPos));
}

float divTiming(float3 origin, float3 timing) {
  return toUnit(origin) / toUnit(timing);
}

float timeFromUnit(float unit) {
  return timePerUnit * unit;
}

#define rep2(u) u, u
#define rep3(u) u, u, u
#define rep4(u) rep2({rep2(u)})
#define rep5(u) u, u, u, u, u
#define rep6(u) rep2({ rep3(u) })
#define rep7(u) rep4(u), rep3(u)
#define rep8(u) rep2({rep4(u)})
#define rep16(u) rep4({rep4(u)})
#define rep32(u) rep2({rep16(u)})
#define rep64(u) rep4({rep16(u)})
#define rep128(u) rep2({rep64(u})
#define rep256(u) rep4({rep64(u)})
#define u1_g(base, umax, v) { base, umax, v }
#define u1(v) u1_g(0, 1, v)
#define u2_g(base, umax, v) { base+0, umax, v }, { base+1, umax, v }
#define u2(v) u2_g(0, 2, v)
#define u3_g(base, umax, v) { base+0, umax, v }, { base+1, umax, v }, { base+2, umax, v }
#define u3(v) u3_g(0, 3, v)
#define u4_g(base, umax, v) u2_g(base+0, umax, v), u2_g(base+2, umax, v)
#define u4(v) u4_g(0, 4, v)
#define u6_g(base, umax, v) u3_g(base+0, umax, v), u3_g(base+3, umax, v)
#define u6(v) u6_g(0, 6, v)
#define b1_g u4_g
#define b1 u4
#define b1_5(v) u4_g(0, 6, v), u2_g(4, 6, v)
#define b2_g(base, umax, v) b1_g(base+0, umax, v), b1_g(base+4, umax, v)
#define b2(v) b2_g(0, 8, v)
#define b3_g(base, umax, v) b2_g(base+0, umax, v), b1_g(base+8, umax, v)
#define b3(v) b3_g(0, 12, v)
#define b4_g(base, umax, v) b2_g(base+0, umax, v), b2_g(base+8, umax, v)
#define b4(v) b4_g(0, 16, v)
#define b5_g(base, umax, v) b2_g(base+0, umax, v), b3_g(base+8, umax, v)
#define b5(v) b5_g(0, 20, v)
#define bar1_g b4_g
#define bar1 b4
#define bar2_g(base, umax, v) bar1_g(base+0, umax, v), bar1_g(base+16, umax, v)
#define bar2(v) bar2_g(0, 32, v)
#define bar3_g(base, umax, v) bar2_g(base+0, umax, v), bar1_g(base+32, umax, v)
#define bar3(v) bar3_g(0, 48, v)
#define bar4_g(base, umax, v) bar2_g(base+0, umax, v), bar2_g(base+32, umax, v)
#define bar4(v) bar4_g(0, 64, v)
#define bar8_g(base, umax, v) bar4_g(base+0, umax, v), bar4_g(base+64, umax, v)
#define bar8(v) bar8_g(0, 128, v)
#define bar16_g(base, umax, v) bar8_g(base+0, umax, v), bar8_g(base+128, umax, v)
#define bar16(v) bar16_g(0, 256, v)
#define bar32_g(base, umax, v) bar16_g(base+0, umax, v), bar16_g(base+256, umax, v)
#define bar32(v) bar16_g(0, 512, v)
#define bar64_g(base, umax, v) bar16_g(base+0, umax, v), bar16_g(base+512, umax, v)
#define bar64(v) bar64_g(0, 1024, v)

struct MusicP {
  float data[3];
  float sUnit;
  float eUnit;
  float rate;
  float value;
};

MusicP newMusicP(in float data[3], float unit) {
  MusicP p;
  p.data = data;
  p.sUnit = unit - (p.data[0] + frac(unit));
  p.eUnit = p.sUnit + p.data[1];
  p.rate = (p.data[0] + frac(unit)) / p.data[1];
  p.value = p.data[2];
  return p;
}

#endif
