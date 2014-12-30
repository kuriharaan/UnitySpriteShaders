Shader "Example/Diffuse Simple Alpha" {
    Properties {
        _MainColor("Color", Color) = (1,1,1)
    }
    SubShader {
        Tags { "RenderType" = "Transparent" }
        CGPROGRAM
        float4 _MainColor;
        #pragma surface surf Lambert alpha
        struct Input {
            float4 color : COLOR;
        };
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _MainColor.rgb * half3(1, 0.5, 0.5);
            o.Alpha = 0.5;
        }
        ENDCG
    }
    Fallback "Diffuse"
}