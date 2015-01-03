Shader "Custom/RotateUV" {

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
				float2 src   = float2(i.uv.x - 0.5, i.uv.y - 0.5);
				float  angle = _SinTime[1] * 20 * sqrt(src.x*src.x + src.y*src.y);
				float2 rot   = float2(cos(angle), sin(angle));
				float2 uv;
				uv.x = rot.x * src.x - rot.y * src.y;
				uv.y = rot.y * src.x + rot.x * src.y;
				uv += float2(0.5, 0.5);
				return tex2D(_MainTex, uv) * i.color;
			}
			ENDCG
		}
	}

}