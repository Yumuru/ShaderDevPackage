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

struct MusicP {
  float3 sUnit;
  float3 eUnit;
  float rate;
  float value;
};

#define GenerateTrans64(name) \
  static float name##_00[4*4*8][4]; \
  static float name##_01[4*4*8][4]; \
  static float name##_02[4*4*8][4]; \
  static float name##_03[4*4*8][4]; \
  static float name##_04[4*4*8][4]; \
  static float name##_05[4*4*8][4]; \
  static float name##_06[4*4*8][4]; \
  static float name##_07[4*4*8][4]; \
  static uint name##Current = 0; \
  void name##_get(uint unit, inout float data[4]) { \
    uint id = unit / (4*4*16); \
    unit = unit % (4*4*16); \
    switch(id) { \
      case  0: data = name##_00[unit]; break; \
      case  1: data = name##_01[unit]; break; \
      case  2: data = name##_02[unit]; break; \
      case  3: data = name##_03[unit]; break; \
      case  4: data = name##_04[unit]; break; \
      case  5: data = name##_05[unit]; break; \
      case  6: data = name##_06[unit]; break; \
      case  7: data = name##_07[unit]; break; \
    } \
  } \
  void name##_set(inout float data[4]) { \
    uint id = name##Current / (4*4*16); \
    uint unit = name##Current++ % (4*4*16); \
    switch(id) { \
      case  0: name##_00[unit] = data; break; \
      case  1: name##_01[unit] = data; break; \
      case  2: name##_02[unit] = data; break; \
      case  3: name##_03[unit] = data; break; \
      case  4: name##_04[unit] = data; break; \
      case  5: name##_05[unit] = data; break; \
      case  6: name##_06[unit] = data; break; \
      case  7: name##_07[unit] = data; break; \
    } \
  } \
  void name##_Append(float unit, float from, float to) { \
    [loop] \
    for (int i = 0; i < unit; i++) { \
      float data[4] = { i, unit, from, to }; \
      name##_set(data); \
    } \
  } \
  void name##_Append(float3 timing, float from, float to) { name##_Append(toUnit(timing), from, to); } \
  MusicP name##_newMusicP(float unit) { \
    MusicP p; \
    float data[4]; \
    name##_get(unit, data); \
    p.sUnit = unit - (data[0] + frac(unit)); \
    p.eUnit = p.sUnit + data[1]; \
    p.rate = (data[0] + frac(unit)) / data[1]; \
    p.value = lerp(data[2], data[3], p.rate); \
    return p; \
  }

#endif
