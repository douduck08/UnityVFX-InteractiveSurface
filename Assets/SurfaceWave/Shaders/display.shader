Shader "Custom/display" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_WaveTex ("Wave", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert fullforwardshadows
		struct Input {
			float2 uv_WaveTex;
		};

		fixed4 _Color;
		sampler2D _WaveTex;

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_WaveTex, IN.uv_WaveTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
