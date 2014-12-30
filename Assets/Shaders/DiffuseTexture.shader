Shader "Example/Diffuse Texture" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderType" = "Opaque" }
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input {
            float2 uv_MainTex;
        };
        sampler2D _MainTex;
        void surf (Input IN, inout SurfaceOutput o) {
			float2 uv = IN.uv_MainTex;
			uv.x += _Time[1] * 0.1f;
            o.Albedo = tex2D (_MainTex, uv).rgb;

        }
        ENDCG
    }
    Fallback "Diffuse"
}