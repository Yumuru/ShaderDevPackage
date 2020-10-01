Shader "Template/Unlit" {
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
			#include "Packages/yumurushaderdev/CGINC/Vector.cginc"

      struct GS_OUT {
        float4 vertex : SV_Position;
        float4 texcoord : TEXCOORD0;
        float4 texcoord3 : TEXCOORD3;
      };

			appdata_full VS(appdata_full v) { return v; }

			// Reference
			// mul(UNITY_MATRIX_P, mul(UNITY_MATRIX_MV, float4(p,1)) + float4(v,0,0))

			#define instanceN 1

			[instance(instanceN)]
			[maxvertexcount(3)]
			void GS(triangle appdata_full i[3], inout TriangleStream<GS_OUT> stream, uint gsid : SV_GSInstanceID) {
				for (int j = 0; j < 3; j++) {
					appdata_full v = i[j];
					GS_OUT o = (GS_OUT) 0;
					uint id = gsid + instanceN * v.texcoord.z;
					bool isShow = true;
					v.vertex.z += id;
					o.texcoord = v.texcoord;
					o.texcoord3.xyz = v.vertex.xyz;
					o.vertex = lerp(0, UnityObjectToClipPos(v.vertex), isShow);
					stream.Append(o);
				}
				stream.RestartStrip();
			}

			float4 FS(appdata_full i) : SV_Target {
				float3 pos = i.texcoord3.xyz;
				float2 uv = i.texcoord.xy;
				return float4(uv, 0, 1);
			}
			ENDCG
		}
	}
}
