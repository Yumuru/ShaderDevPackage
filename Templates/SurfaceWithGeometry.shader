Shader "Template/SurfaceWithGeometry" {
  Properties {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Albedo (RGB)", 2D) = "white" {}
    _Glossiness ("Smoothness", Range(0,1)) = 0.5
    _Metallic ("Metallic", Range(0,1)) = 0.0
  }
  SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 200

    Pass {
      Name "FORWARD"
      Tags { "LightMode" = "ForwardBase" }
      CGPROGRAM

      #pragma vertex vert
      #pragma geometry geo
      #pragma fragment frag
      #pragma target 5.0
      #pragma multi_compile_fwdbase

      #include "HLSLSupport.cginc"
      #include "UnityShaderVariables.cginc"
      #include "UnityShaderUtilities.cginc"
      #include "UnityCG.cginc"
      #include "Lighting.cginc"
      #include "UnityPBSLighting.cginc"
      #include "AutoLight.cginc"

      sampler2D _MainTex; float4 _MainTex_ST;
      half _Glossiness;
      half _Metallic;
      fixed4 _Color;

      struct Input {
        float2 uv_MainTex;
      };

      struct frag_IN {
        UNITY_POSITION(pos);
        float2 pack0 : TEXCOORD0;
        float3 worldNormal : TEXCOORD1;
        float3 worldPos : TEXCOORD2;
        UNITY_SHADOW_COORDS(5)
      };

      appdata_full vert(appdata_full v) { return v; }

      #define instanceN 1

      [instance(instanceN)]
      [maxvertexcount(3)]
      void geo(triangle appdata_full i[3], inout TriangleStream<frag_IN> stream, uint gsid : SV_GSInstanceID) {
        for (int j = 0; j < 3; j++) {
          appdata_full v = i[j];
          uint id = gsid + instanceN * v.texcoord.z;
          frag_IN o;
          UNITY_INITIALIZE_OUTPUT(frag_IN, o);
          o.pos = UnityObjectToClipPos(v.vertex);
          o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
          o.worldPos.xyz = mul(unity_ObjectToWorld, v.vertex).xyz;
          o.worldNormal = UnityObjectToWorldNormal(v.normal);
          UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
          stream.Append(o);
        }
        stream.RestartStrip();
      }

      void surf(Input IN, inout SurfaceOutputStandard o) {
        fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        o.Albedo = c.rgb;
        o.Metallic = _Metallic;
        o.Smoothness = _Glossiness;
        o.Alpha = c.a;
        o.Emission = 1;
      }

      fixed4 frag(frag_IN IN) : SV_Target {
        SurfaceOutputStandard o;
        UNITY_INITIALIZE_OUTPUT(SurfaceOutputStandard, o);
        Input input;
        input.uv_MainTex = IN.pack0;
        o.Emission = 0.0;
        o.Occlusion = 1.0;
        o.Normal = IN.worldNormal;

        surf(input, o);

        float3 worldPos = IN.worldPos;
        #ifndef USING_DIRECTIONAL_LIGHT
          fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
        #else
          fixed3 lightDir = _WorldSpaceLightPos0.xyz;
        #endif
        float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

        UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)

        fixed4 c = 0;
        UnityGI gi;
        UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
        gi.light.color = _LightColor0.rgb;
        gi.light.dir = lightDir;

        UnityGIInput giInput;
        UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
        giInput.light = gi.light;
        giInput.worldPos = worldPos;
        giInput.worldViewDir = worldViewDir;
        giInput.atten = atten;

        giInput.probeHDR[0] = unity_SpecCube0_HDR;
        giInput.probeHDR[1] = unity_SpecCube1_HDR;
        #if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
          giInput.boxMin[0] = unity_SpecCube0_BoxMin;
        #endif
        LightingStandard_GI(o, giInput, gi);
        c += LightingStandard(o, worldViewDir, gi);
        return c;
      }
    ENDCG
    }
  }
  FallBack "Diffuse"
}
