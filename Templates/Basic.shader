Shader "beta_Lib/Template/Basic" {
	Properties {
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma target 5.0
			#pragma vertex VS
			#pragma fragment FS
			
			#include "UnityCG.cginc"
			#include "Assets/CGINC/YumuruCGINC.cginc"

			struct VS_IN {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct VS_OUT {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 pos : TEXCOORD1;
			};

			#define TO_VIEW(p, v) \
				mul(UNITY_MATRIX_P, mul(UNITY_MATRIX_MV, float4(p,1)) + float4(v,0,0))

			VS_OUT VS(VS_IN v) {
				VS_OUT o;
				o.pos = v.vertex;
				o.vertex = UnityObjectToClipPos(o.pos);
				o.uv = v.uv;
				return o;
			}

			float4 FS(VS_OUT i) : SV_Target {
				return float4(i.uv, 0, 1);
			}
			ENDCG
		}
	}
}
