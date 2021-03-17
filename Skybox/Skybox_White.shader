Shader "Skybox/White" {
	Properties {
	}
	SubShader {
		Tags {
			"RenderType"="Background"
			"Queue"="Background"
			"PreviewType"="Skybox"
		}
		LOD 100

		ZWrite Off
		Cull Off

		Pass {
			CGPROGRAM
			#pragma target 4.0
			#pragma vertex VS
			#pragma fragment FS
			
			#include "UnityCG.cginc"

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
				return 1;
			}
			ENDCG
		}
	}
}
