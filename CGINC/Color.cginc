#ifndef Color
#define Color

#define Color16(value) \
  fixed3(frac((value >> 16) / 256.0), frac((value >> 8) / 256.0), frac((value >> 0) / 256.0))

// 003
#define Emerald_Blue Color16(0x00b5de)
#define Papaya Color16(0xf8b516)
#define Dragon_Fruit Color16(0xd01026)
#define Juicy_Orange Color16(0xec6c1f)
#define Guava_Juice Color16(0xe94c4d)
#define Banana Color16(0xedda15)
#define Golden_Kiwi Color16(0xc2ca2e)
#define Kiwi_Fruit Color16(0x73a82d)
#define Jungle_Green Color16(0x2a6d39)

// 007
#define Spectrum_Red Color16(0xe50011)
#define Spectrum_Orange Color16(0xee7700)
#define Spectrum_Yellor Color16(0xfff000)
#define Spectrum_Green Color16(0x00a73b)
#define Spectrum_Blue Color16(0x0064b3)
#define Spectrum_Violet Color16(0x5f1885)
#define Indigo Color16(0x2a2489)
#define Pure_White Color16(0xfefefe)
#define Pure_Black Color16(0x000000)

// 008
#define Bright_Yellow Color16(0xffe600)
#define Clear_Turquoise Color16(0x0bd8d9)
#define Spring_Green Color16(0xa3ca0e)
#define Bright_Pink Color16(0xc84283)
#define Pure_Blue Color16(0x2660ac)
#define Briliant_Orange Color16(0xea5419)
#define Summer_Green Color16(0x008442)
#define Light_Orange Color16(0xf08a37)
#define Cheerful_Yellow Color16(0xf8b800)

// 011
#define Easter_Egg Color16(0xffe567)
#define Light_Emerald Color16(0x94d0bf)
#define Sweet_Pink Color16(0xf4b2ba)
#define Light_Purple Color16(0xe4c1db)

// 014
#define Reflection_Blue Color16(0x9fd8ee)
#define Bubble_White Color16(0xeaf6fd)
#define Sunlight_Yellow Color16(0xe2eba3)
#define Air_Blue Color16(0xb4d4ee)

// 034
#define Indian_Ocean Color16(0x419acf)
#define My_Blue Color16(0x72c6c7)

#endif
