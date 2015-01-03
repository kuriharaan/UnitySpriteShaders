Shader "Custom/Scattering" {
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
				float scale = (_SinTime[1] * 0.5 + 0.5 ) * 2.0;
				float2 uv = i.uv;
				//uv.x *= 1.0 / scale;
				//uv.y *= 1.0 / scale;
				float4 rgb = tex2D(_MainTex, uv) * i.color;

				//rgb.a *= (3 > ( (i.pos.x + _Time[1] * 10.0) % 4));
				//rgb.a *= (3 > ( (i.pos.y + _Time[1] * 5.0) % 4));
				rgb.a *= min( 1.0, max( 0.0, i.pos.y - 300 ) );

				return rgb;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
