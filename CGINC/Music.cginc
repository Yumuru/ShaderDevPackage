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
#define rep7(u) rep4(u), rep3(u)
#define rep8(u) rep2({rep4(u)})
#define rep16(u) rep4({rep4(u)})
#define rep32(u) rep2({rep16(u)})
#define rep64(u) rep4({rep16(u)})
#define rep128(u) rep2({rep64(u})
#define rep256(u) rep4({rep64(u)})
#define u1(from, to) { 0, 1, from, to }
#define u1_c(v) u1(rep2(v))
#define u2_g(base, umax, from, to) { base+0, umax, from, to }, { base+1, umax, from, to }
#define u2(from, to) u2_g(0, 2, from, to)
#define u2_c(v) u2(rep2(v))
#define u3_g(base, umax, from, to) { base+0, umax, from, to}, { base+1, umax, from, to }, { base+2, umax, from, to }
#define u3(from, to) u3_g(0, 3, from, to)
#define u3_c(v) u3(rep2(v))
#define u4_g(base, umax, from, to) u2_g(base+0, umax, from, to), u2_g(base+2, umax, from, to)
#define u4(from, to) u4_g(0, 4, from, to)
#define u4_c(v) u4(rep2(v))
#define b1_g u4_g
#define b1 u4
#define b1_c(v) b1(rep2(v))
#define b1_5(from, to) u4_g(0, 6, from, to), u2_g(4, 6, from, to)
#define b2_g(base, umax, from, to) b1_g(base+0, umax, from, to), b1_g(base+4, umax, from, to)
#define b2(from, to) b2_g(0, 8, from, to)
#define b2_c(v) b2(rep2(v))
#define b3_g(base, umax, from, to) b2_g(base+0, umax, from, to), b1_g(base+8, umax, from, to)
#define b3(from, to) b3_g(0, 12, from, to)
#define b3_c(v) b3(rep2(v))
#define b4_g(base, umax, from, to) b2_g(base+0, umax, from, to), b2_g(base+8, umax, from, to)
#define b4(from, to) b4_g(0, 16, from, to)
#define b4_c(v) b4(rep2(v))
#define bar1_g b4_g
#define bar1 b4
#define bar1_c(v) bar1(rep2(v))
#define bar2_g(base, umax, from, to) bar1_g(base+0, umax, from, to), bar1_g(base+16, umax, from, to)
#define bar2(from, to) bar2_g(0, 32, from, to)
#define bar2_c(v) bar2(rep2(v))
#define bar3_g(base, umax, from, to) bar2_g(base+0, umax, from, to), bar1_g(base+32, umax, from, to)
#define bar3(from, to) bar3_g(0, 48, from, to)
#define bar3_c(v) bar3(rep2(v))
#define bar4_g(base, umax, from, to) bar2_g(base+0, umax, from, to), bar2_g(base+32, umax, from, to)
#define bar4(from, to) bar4_g(0, 64, from, to)
#define bar4_c(v) bar4(rep2(v))
#define bar8_g(base, umax, from, to) bar4_g(base+0, umax, from, to), bar4_g(base+64, umax, from, to)
#define bar8(from, to) bar8_g(0, 128, from, to)
#define bar8_c(v) bar8(rep2(v))
#define bar16_g(base, umax, from, to) bar8_g(base+0, umax, from, to), bar8_g(base+128, umax, from, to)
#define bar16(from, to) bar16_g(0, 256, from, to)
#define bar16_c(v) bar16(rep2(v))
#define bar32_g(base, umax, from, to) bar16_g(base+0, umax, from, to), bar16_g(base+256, umax, from, to)
#define bar32(from, to) bar16_g(0, 512, from, to)
#define bar32_c(v) bar16(rep2(v))
#define bar64_g(base, umax, from, to) bar16_g(base+0, umax, from, to), bar16_g(base+512, umax, from, to)
#define bar64(from, to) bar64_g(0, 1024, from, to)
#define bar64_c(v) bar64(rep2(v))

struct MusicP {
  float data[4];
  float3 sUnit;
  float3 eUnit;
  float rate;
  float value;
};

MusicP newMusicP(in float data[4], float unit) {
  MusicP p;
  p.data = data;
  p.sUnit = unit - (p.data[0] + frac(unit));
  p.eUnit = p.sUnit + p.data[1];
  p.rate = (p.data[0] + frac(unit)) / p.data[1];
  p.value = lerp(p.data[2], p.data[3], p.rate);
  return p;
}

#endif
