Shader "beta_Lib/Template/Geo" {
	Properties {
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma target 5.0
			#pragma vertex VS
			#pragma geometry GS
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
			};

			struct GS_OUT {
				float2 uv : TEXCOORD0;
				float3 pos : TEXCOORD1;
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
			};

			VS_OUT VS(VS_IN v) {
				VS_OUT o;
				o.vertex = v.vertex;
				o.uv = v.uv;
				return o;
			}
		
			static uint _Resolution = 128;

			#define TO_VIEW(p, v) \
				mul(UNITY_MATRIX_P, mul(UNITY_MATRIX_MV, float4(p,1)) + float4(v,0,0))

			[maxvertexcount(4)]
			[instance(1)]
			void GS(triangle VS_OUT i[3], inout TriangleStream<GS_OUT> stream, uint gsid : SV_GSInstanceID) {
				GS_OUT o = (GS_OUT)0;
				float2 uv = (i[0].uv + i[1].uv + i[2].uv) / 3;
				float3 normal = normalize(cross(i[1].vertex - i[0].vertex, i[2].vertex - i[0].vertex));
				uv.x = (floor(uv.x * _Resolution*2)) / (_Resolution*2);
				uv.y = floor(uv.y * _Resolution) / _Resolution;
				uint2 iuv = uint2(uv.x * _Resolution*2, uv.y * _Resolution);
				uint id = uv.x * _Resolution*2 + uv.y * _Resolution * (_Resolution*2)
								+ gsid * _Resolution*2*_Resolution;
				o.color = 0;
				#define AddVert \
					o.pos = float4(o.uv - 0.5, id, 0); \
					o.vertex = UnityObjectToClipPos(o.pos); \
					stream.Append(o) 
				o.uv = float2(0, 0);
				AddVert;
				o.uv = float2(0, 1);
				AddVert;
				o.uv = float2(1, 0);
				AddVert;
				o.uv = float2(1, 1);
				AddVert;
				stream.RestartStrip();
			}
			
			float4 FS(GS_OUT i) : SV_Target {
				return float4(i.uv, 0, 1);
			}
			ENDCG
		}
	}
}
