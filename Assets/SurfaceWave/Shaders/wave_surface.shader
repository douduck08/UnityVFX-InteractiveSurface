Shader "Custom/wave_surface" {
	Properties {
		_Color ("Color", Color) = (1, 1, 1, 1)
		_WaveTex ("Wave", 2D) = "black" {}
        _Param("Factor", Vector) = (1, 1, 0, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		struct Input {
			float2 uv_NormalMap;
		};

		sampler2D _WaveTex;
        float4 _Color;
        float4 _Param;  // [height factor, normal factor, 0, 0]
        float2 _Stride;

        void vert (inout appdata_full v) {
            float2 uv = v.texcoord.xy;
            float height  = tex2Dlod (_WaveTex, float4(uv, 0, 0)).r * 2 - 1;
            v.vertex.xyz += v.normal * height * _Param.x;

            float up    = tex2Dlod(_WaveTex, float4(uv.x, uv.y + _Stride.y, 0, 0)).r * 2 - 1;
            float down  = tex2Dlod(_WaveTex, float4(uv.x, uv.y - _Stride.y, 0, 0)).r * 2 - 1;
            float left  = tex2Dlod(_WaveTex, float4(uv.x - _Stride.x, uv.y, 0, 0)).r * 2 - 1;
            float right = tex2Dlod(_WaveTex, float4(uv.x + _Stride.x, uv.y, 0, 0)).r * 2 - 1;
            float nx = left - right;
            float ny = down - up;
            v.normal = normalize(float3(nx, ny, -_Param.y));
            v.tangent = normalize(float4(_Param.y, ny, nx, -1));
        }

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
