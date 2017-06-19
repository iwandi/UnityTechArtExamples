Shader "Unlit/ShaderTry"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SubTex ("Texture", 2D) = "white" {}
		_Blend ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 c : COLOR;
			};

			struct v2f
			{
				float2 uv0 : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 c : COLOR;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _SubTex;
			float4 _SubTex_ST;

			sampler2D _Blend;
			float4 _Blend_ST;
			
			v2f vert (appdata input)
			{
				v2f output;
				output.vertex = UnityObjectToClipPos(input.vertex);
				output.uv0 = TRANSFORM_TEX(input.uv, _MainTex);	
				output.uv1 = TRANSFORM_TEX(input.uv, _SubTex);	
				output.c = input.c;			
				return output;
			}
			
			fixed4 frag (v2f input) : SV_Target
			{
				fixed4 colMain = tex2D(_MainTex, input.uv0);
				fixed4 colSub = tex2D(_SubTex, input.uv1);

				//float mat = floor(input.c.g * 2);
				//float mat = clamp((input.c.g - 0.5) * 2 , 0, 1);
				float mat = tex2D(_Blend, input.uv0).r;

				fixed4 cG = colMain * mat;
				fixed4 cB = colSub * (1- mat);

				return  (cG + cB);
			}
			ENDCG
		}
	}
}
