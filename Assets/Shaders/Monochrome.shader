Shader "Custom/monochrome" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
    }

	SubShader {
		Pass {
			Lighting Off
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			struct v2f {
				float4 pos : SV_POSITION;
				half2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			v2f vert( appdata_full v )
			{
				v2f o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
				o.uv = MultiplyUV( UNITY_MATRIX_TEXTURE0, v.texcoord );
				o.color = v.color;
				return o;
			}

			float4 frag(v2f i) : COLOR {
				float4 rgb = tex2D(_MainTex, i.uv) * i.color;

				float3 yuv = float3( 0.299   * rgb[0] + 0.587   * rgb[1] + 0.114   * rgb[2],
				                    -0.14713 * rgb[0] - 0.28886 * rgb[1] + 0.436   * rgb[2],
									 0.615   * rgb[0] - 0.51499 * rgb[1] - 0.10001 * rgb[2]);

				float scale = _CosTime[1] * 0.5 + 0.5;
				yuv[1] *= scale;
				yuv[2] *= scale;
				rgb[0] = yuv[0] + 1.13983 * yuv[2];
				rgb[1] = yuv[0] - 0.39465 * yuv[1] - 0.58060 * yuv[2];
				rgb[2] = yuv[0] + 2.03211 * yuv[1];

				return rgb;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
