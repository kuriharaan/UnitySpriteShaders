Shader "Example/Diffuse Simple" {
    Properties {
        _MainColor("Color", Color) = (1,1,1)
    }
    SubShader {
        Tags { "RenderType" = "Opaque" }
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input {
            float4 color : COLOR;
        };
        float4 _MainColor;
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _MainColor.rgb;
        }
        ENDCG
    }
    Fallback "Diffuse"
}