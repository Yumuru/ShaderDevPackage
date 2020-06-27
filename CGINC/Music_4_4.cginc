#ifndef Music
#define Music

#define beatPerBar 4
#define unitPerBeat 4
#define unitPerBar unitPerBeat * beatPerBar

#define bar1_g b4_g // 数字をbeatPerBarの値に合わせる
#define b1_g u4_g   // 数字をunitPerBeatの値に合わせる

#define BPM 160
static float timePerBeat = 60.0 / BPM;
static float timePerBar = timePerBeat * beatPerBar;
static float timePerUnit = timePerBeat / unitPerBeat;
float timeFromUnit(float unit) {
  return timePerUnit * unit;
}

float3 timingFromMusicPos(float bar) {
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

float newUnit(float bar, float beat, float unit) {
  return toUnit(float3(bar, beat, unit));
}

float unitFromMusicPos(float musicPos) {
  return toUnit(timingFromMusicPos(musicPos));
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

#define upb unitPerBeat
#define upba unitPerBar

#define u1_g(base, umax, v) { base, umax, v }
#define u2_g(base, umax, v) { base+0, umax, v }, { base+1, umax, v }
#define u3_g(base, umax, v) u2_g(base+0, umax, v), { base+2, umax, v }
#define u4_g(base, umax, v) u2_g(base+0, umax, v), u2_g(base+2, umax, v)
#define u5_g(base, umax, v) u2_g(base+0, umax, v), u3_g(base+2, umax, v)
#define u6_g(base, umax, v) u3_g(base+0, umax, v), u3_g(base+3, umax, v)
#define u7_g(base, umax, v) u3_g(base+0, umax, v), u4_g(base+3, umax, v)
#define u8_g(base, umax, v) u4_g(base+0, umax, v), u4_g(base+4, umax, v)
#define u9_g(base, umax, v) u4_g(base+0, umax, v), u5_g(base+4, umax, v)
#define u10_g(base, umax, v) u5_g(base+0, umax, v), u5_g(base+5, umax, v)
#define u11_g(base, umax, v) u5_g(base+0, umax, v), u6_g(base+5, umax, v)
#define u12_g(base, umax, v) u6_g(base+0, umax, v), u6_g(base+6, umax, v)
#define u13_g(base, umax, v) u7_g(base+0, umax, v), u6_g(base+6, umax, v)
#define u14_g(base, umax, v) u7_g(base+0, umax, v), u7_g(base+7, umax, v)
#define u15_g(base, umax, v) u7_g(base+0, umax, v), u8_g(base+7, umax, v)
#define u16_g(base, umax, v) u8_g(base+0, umax, v), u8_g(base+8, umax, v)
#define u17_g(base, umax, v) u8_g(base+0, umax, v), u9_g(base+8, umax, v)
#define u18_g(base, umax, v) u9_g(base+0, umax, v), u9_g(base+9, umax, v)
#define u19_g(base, umax, v) u9_g(base+0, umax, v), u10_g(base+9, umax, v)
#define u20_g(base, umax, v) u10_g(base+0, umax, v), u10_g(base+10, umax, v)
#define u21_g(base, umax, v) u10_g(base+0, umax, v), u11_g(base+10, umax, v)
#define u22_g(base, umax, v) u11_g(base+0, umax, v), u11_g(base+11, umax, v)
#define u23_g(base, umax, v) u11_g(base+0, umax, v), u12_g(base+11, umax, v)
#define u24_g(base, umax, v) u12_g(base+0, umax, v), u12_g(base+12, umax, v)
#define u25_g(base, umax, v) u12_g(base+0, umax, v), u13_g(base+12, umax, v)
#define u26_g(base, umax, v) u13_g(base+0, umax, v), u13_g(base+13, umax, v)
#define u27_g(base, umax, v) u13_g(base+0, umax, v), u14_g(base+13, umax, v)
#define u28_g(base, umax, v) u14_g(base+0, umax, v), u14_g(base+14, umax, v)
#define u29_g(base, umax, v) u14_g(base+0, umax, v), u15_g(base+14, umax, v)
#define u30_g(base, umax, v) u15_g(base+0, umax, v), u15_g(base+15, umax, v)
#define u31_g(base, umax, v) u15_g(base+0, umax, v), u16_g(base+15, umax, v)
#define u32_g(base, umax, v) u16_g(base+0, umax, v), u16_g(base+16, umax, v)
#define b2_g(base, umax, v) b1_g(base+0, umax, v), b1_g(base+upb*1, umax, v)
#define b3_g(base, umax, v) b1_g(base+0, umax, v), b2_g(base+upb*1, umax, v)
#define b4_g(base, umax, v) b2_g(base+0, umax, v), b2_g(base+upb*2, umax, v)
#define b5_g(base, umax, v) b2_g(base+0, umax, v), b3_g(base+upb*2, umax, v)
#define b6_g(base, umax, v) b3_g(base+0, umax, v), b3_g(base+upb*3, umax, v)
#define b7_g(base, umax, v) b3_g(base+0, umax, v), b4_g(base+upb*3, umax, v)
#define b8_g(base, umax, v) b4_g(base+0, umax, v), b4_g(base+upb*4, umax, v)
#define b9_g(base, umax, v) b4_g(base+0, umax, v), b5_g(base+upb*4, umax, v)
#define b10_g(base, umax, v) b5_g(base+0, umax, v), b5_g(base+upb*5, umax, v)
#define b11_g(base, umax, v) b5_g(base+0, umax, v), b6_g(base+upb*5, umax, v)
#define b12_g(base, umax, v) b6_g(base+0, umax, v), b6_g(base+upb*6, umax, v)
#define b13_g(base, umax, v) b6_g(base+0, umax, v), b7_g(base+upb*6, umax, v)
#define b14_g(base, umax, v) b7_g(base+0, umax, v), b7_g(base+upb*7, umax, v)
#define b15_g(base, umax, v) b7_g(base+0, umax, v), b8_g(base+upb*7, umax, v)
#define b16_g(base, umax, v) b8_g(base+0, umax, v), b8_g(base+upb*8, umax, v)
#define b17_g(base, umax, v) b8_g(base+0, umax, v), b9_g(base+upb*8, umax, v)
#define b18_g(base, umax, v) b9_g(base+0, umax, v), b9_g(base+upb*9, umax, v)
#define b19_g(base, umax, v) b9_g(base+0, umax, v), b10_g(base+upb*9, umax, v)
#define b20_g(base, umax, v) b10_g(base+0, umax, v), b10_g(base+upb*10, umax, v)
#define b21_g(base, umax, v) b10_g(base+0, umax, v), b11_g(base+upb*10, umax, v)
#define b22_g(base, umax, v) b11_g(base+0, umax, v), b11_g(base+upb*11, umax, v)
#define b23_g(base, umax, v) b11_g(base+0, umax, v), b12_g(base+upb*11, umax, v)
#define b24_g(base, umax, v) b12_g(base+0, umax, v), b12_g(base+upb*12, umax, v)
#define b25_g(base, umax, v) b12_g(base+0, umax, v), b13_g(base+upb*12, umax, v)
#define b26_g(base, umax, v) b13_g(base+0, umax, v), b13_g(base+upb*13, umax, v)
#define b27_g(base, umax, v) b13_g(base+0, umax, v), b14_g(base+upb*13, umax, v)
#define b28_g(base, umax, v) b14_g(base+0, umax, v), b14_g(base+upb*14, umax, v)
#define b29_g(base, umax, v) b14_g(base+0, umax, v), b15_g(base+upb*14, umax, v)
#define b30_g(base, umax, v) b15_g(base+0, umax, v), b15_g(base+upb*15, umax, v)
#define b31_g(base, umax, v) b15_g(base+0, umax, v), b16_g(base+upb*15, umax, v)
#define b32_g(base, umax, v) b16_g(base+0, umax, v), b16_g(base+upb*16, umax, v)
#define bar2_g(base, umax, v) bar1_g(base+0, umax, v), bar1_g(base+upba*1, umax, v)
#define bar3_g(base, umax, v) bar1_g(base+0, umax, v), bar2_g(base+upba*1, umax, v)
#define bar4_g(base, umax, v) bar2_g(base+0, umax, v), bar2_g(base+upba*2, umax, v)
#define bar5_g(base, umax, v) bar2_g(base+0, umax, v), bar3_g(base+upba*2, umax, v)
#define bar6_g(base, umax, v) bar3_g(base+0, umax, v), bar3_g(base+upba*3, umax, v)
#define bar7_g(base, umax, v) bar3_g(base+0, umax, v), bar4_g(base+upba*3, umax, v)
#define bar8_g(base, umax, v) bar4_g(base+0, umax, v), bar4_g(base+upba*4, umax, v)
#define bar9_g(base, umax, v) bar4_g(base+0, umax, v), bar5_g(base+upba*4, umax, v)
#define bar10_g(base, umax, v) bar5_g(base+0, umax, v), bar5_g(base+upba*5, umax, v)
#define bar11_g(base, umax, v) bar5_g(base+0, umax, v), bar6_g(base+upba*5, umax, v)
#define bar12_g(base, umax, v) bar6_g(base+0, umax, v), bar6_g(base+upba*6, umax, v)
#define bar13_g(base, umax, v) bar6_g(base+0, umax, v), bar7_g(base+upba*6, umax, v)
#define bar14_g(base, umax, v) bar7_g(base+0, umax, v), bar7_g(base+upba*7, umax, v)
#define bar15_g(base, umax, v) bar7_g(base+0, umax, v), bar8_g(base+upba*7, umax, v)
#define bar16_g(base, umax, v) bar8_g(base+0, umax, v), bar8_g(base+upba*8, umax, v)
#define bar17_g(base, umax, v) bar8_g(base+0, umax, v), bar9_g(base+upba*8, umax, v)
#define bar18_g(base, umax, v) bar9_g(base+0, umax, v), bar9_g(base+upba*9, umax, v)
#define bar19_g(base, umax, v) bar9_g(base+0, umax, v), bar10_g(base+upba*9, umax, v)
#define bar20_g(base, umax, v) bar10_g(base+0, umax, v), bar10_g(base+upba*10, umax, v)
#define bar21_g(base, umax, v) bar10_g(base+0, umax, v), bar11_g(base+upba*10, umax, v)
#define bar22_g(base, umax, v) bar11_g(base+0, umax, v), bar11_g(base+upba*11, umax, v)
#define bar23_g(base, umax, v) bar11_g(base+0, umax, v), bar12_g(base+upba*11, umax, v)
#define bar24_g(base, umax, v) bar12_g(base+0, umax, v), bar12_g(base+upba*12, umax, v)
#define bar25_g(base, umax, v) bar12_g(base+0, umax, v), bar13_g(base+upba*12, umax, v)
#define bar26_g(base, umax, v) bar13_g(base+0, umax, v), bar13_g(base+upba*13, umax, v)
#define bar27_g(base, umax, v) bar13_g(base+0, umax, v), bar14_g(base+upba*13, umax, v)
#define bar28_g(base, umax, v) bar14_g(base+0, umax, v), bar14_g(base+upba*14, umax, v)
#define bar29_g(base, umax, v) bar14_g(base+0, umax, v), bar15_g(base+upba*14, umax, v)
#define bar30_g(base, umax, v) bar15_g(base+0, umax, v), bar15_g(base+upba*15, umax, v)
#define bar31_g(base, umax, v) bar15_g(base+0, umax, v), bar16_g(base+upba*15, umax, v)
#define bar32_g(base, umax, v) bar16_g(base+0, umax, v), bar16_g(base+upba*16, umax, v)
#define bar48_g(base, umax, v) bar24_g(base+0, umax, v), bar24_g(base+upba*24, umax, v)
#define bar64_g(base, umax, v) bar32_g(base+0, umax, v), bar32_g(base+upba*32, umax, v)
#define u1(v)  u1_g(0,  1, v)
#define u2(v)  u2_g(0,  2, v)
#define u3(v)  u3_g(0,  3, v)
#define u4(v)  u4_g(0,  4, v)
#define u5(v)  u5_g(0,  5, v)
#define u6(v)  u6_g(0,  6, v)
#define u7(v)  u7_g(0,  7, v)
#define u8(v)  u8_g(0,  8, v)
#define u9(v)  u9_g(0,  9, v)
#define u10(v) u10_g(0, 10, v)
#define u11(v) u11_g(0, 11, v)
#define u12(v) u12_g(0, 12, v)
#define u13(v) u13_g(0, 13, v)
#define u14(v) u14_g(0, 14, v)
#define u15(v) u15_g(0, 15, v)
#define u16(v) u16_g(0, 16, v)
#define u17(v) u17_g(0, 17, v)
#define u18(v) u18_g(0, 18, v)
#define u19(v) u19_g(0, 19, v)
#define u20(v) u20_g(0, 20, v)
#define u21(v) u21_g(0, 21, v)
#define u22(v) u22_g(0, 22, v)
#define u23(v) u23_g(0, 23, v)
#define u24(v) u24_g(0, 24, v)
#define u25(v) u25_g(0, 25, v)
#define u26(v) u26_g(0, 26, v)
#define u27(v) u27_g(0, 27, v)
#define u28(v) u28_g(0, 28, v)
#define u29(v) u29_g(0, 29, v)
#define u30(v) u30_g(0, 30, v)
#define u31(v) u31_g(0, 31, v)
#define u32(v) u32_g(0, 32, v)
#define b1(v)  b1_g(0,  upb*1, v)
#define b2(v)  b2_g(0,  upb*2, v)
#define b3(v)  b3_g(0,  upb*3, v)
#define b4(v)  b4_g(0,  upb*4, v)
#define b5(v)  b5_g(0,  upb*5, v)
#define b6(v)  b6_g(0,  upb*6, v)
#define b7(v)  b7_g(0,  upb*7, v)
#define b8(v)  b8_g(0,  upb*8, v)
#define b9(v)  b9_g(0,  upb*9, v)
#define b10(v) b10_g(0, upb*10, v)
#define b11(v) b11_g(0, upb*11, v)
#define b12(v) b12_g(0, upb*12, v)
#define b13(v) b13_g(0, upb*13, v)
#define b14(v) b14_g(0, upb*14, v)
#define b15(v) b15_g(0, upb*15, v)
#define b16(v) b16_g(0, upb*16, v)
#define b17(v) b17_g(0, upb*17, v)
#define b18(v) b18_g(0, upb*18, v)
#define b19(v) b19_g(0, upb*19, v)
#define b20(v) b20_g(0, upb*20, v)
#define b21(v) b21_g(0, upb*21, v)
#define b22(v) b22_g(0, upb*22, v)
#define b23(v) b23_g(0, upb*23, v)
#define b24(v) b24_g(0, upb*24, v)
#define b25(v) b25_g(0, upb*25, v)
#define b26(v) b26_g(0, upb*26, v)
#define b27(v) b27_g(0, upb*27, v)
#define b28(v) b28_g(0, upb*28, v)
#define b29(v) b29_g(0, upb*29, v)
#define b30(v) b30_g(0, upb*30, v)
#define b31(v) b31_g(0, upb*31, v)
#define b32(v) b32_g(0, upb*32, v)
#define bar1(v)  bar1_g(0,  upba*1, v)
#define bar2(v)  bar2_g(0,  upba*2, v)
#define bar3(v)  bar3_g(0,  upba*3, v)
#define bar4(v)  bar4_g(0,  upba*4, v)
#define bar5(v)  bar5_g(0,  upba*5, v)
#define bar6(v)  bar6_g(0,  upba*6, v)
#define bar7(v)  bar7_g(0,  upba*7, v)
#define bar8(v)  bar8_g(0,  upba*8, v)
#define bar9(v)  bar9_g(0,  upba*9, v)
#define bar10(v) bar10_g(0, upba*10, v)
#define bar11(v) bar11_g(0, upba*11, v)
#define bar12(v) bar12_g(0, upba*12, v)
#define bar13(v) bar13_g(0, upba*13, v)
#define bar14(v) bar14_g(0, upba*14, v)
#define bar15(v) bar15_g(0, upba*15, v)
#define bar16(v) bar16_g(0, upba*16, v)
#define bar17(v) bar17_g(0, upba*17, v)
#define bar18(v) bar18_g(0, upba*18, v)
#define bar19(v) bar19_g(0, upba*19, v)
#define bar20(v) bar20_g(0, upba*20, v)
#define bar21(v) bar21_g(0, upba*21, v)
#define bar22(v) bar22_g(0, upba*22, v)
#define bar23(v) bar23_g(0, upba*23, v)
#define bar24(v) bar24_g(0, upba*24, v)
#define bar25(v) bar25_g(0, upba*25, v)
#define bar26(v) bar26_g(0, upba*26, v)
#define bar27(v) bar27_g(0, upba*27, v)
#define bar28(v) bar28_g(0, upba*28, v)
#define bar29(v) bar29_g(0, upba*29, v)
#define bar30(v) bar30_g(0, upba*30, v)
#define bar31(v) bar31_g(0, upba*31, v)
#define bar32(v) bar32_g(0, upba*32, v)
#define bar48(v) bar48_g(0, upba*48, v)
#define bar64(v) bar64_g(0, upba*64, v)

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
