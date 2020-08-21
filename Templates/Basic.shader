Shader "Template/Basic" {
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

			appdata_full VS(appdata_full v) { return v; }

			// Reference
			// mul(UNITY_MATRIX_P, mul(UNITY_MATRIX_MV, float4(p,1)) + float4(v,0,0))

			#define instanceN 1
			#define GSCopyN 1

			[instance(instanceN)]
			[maxvertexcount(3 * GSCopyN)]
			void GS(triangle appdata_full i[3], inout TriangleStream<appdata_full> stream, uint gsid : SV_GSInstanceID) {
				for (int rep = 0; rep < GSCopyN; rep++) {
					for (int j = 0; j < 3; j++) {
						appdata_full v = i[j];
						uint id = gsid + instanceN * rep + instanceN * GSCopyN * v.texcoord.z;
						bool isShow = true;
						v.vertex.z += id;
						v.texcoord3.xyz = v.vertex.xyz;
						v.vertex = lerp(0, UnityObjectToClipPos(v.vertex), isShow);
						stream.Append(v);
					}
					stream.RestartStrip();
				}
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
