Shader "Custom/Distortion" {

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
				float2 uv = i.uv;
				uv.x += sin(i.uv.y * 270.0f) * _SinTime[3] * 0.03f;
				return tex2D(_MainTex, uv) * i.color;
			}
			ENDCG
		}
	}

}