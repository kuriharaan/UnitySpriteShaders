Shader "Example/Transform Vertex" {

	Properties {
		_WaveParam ("Wave parameter", Range (0.0, 1.0)) = 0.5
	}

    SubShader {
        Tags { "RenderType" = "Opaque" }
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        struct Input {
            float4 color : COLOR;
        };
        float _WaveParam;
        void vert (inout appdata_full v) {
            v.vertex.x += 0.1 * v.normal.x * sin(_Time[1]* v.vertex.y * 3.14 * 2);
            v.vertex.z += 0.1 * v.normal.z * sin(_Time[1]* v.vertex.y * 3.14 * 2);
        }
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = half3(1, 0.5, 0.5);
        }
        ENDCG
    }
    Fallback "Diffuse"
}