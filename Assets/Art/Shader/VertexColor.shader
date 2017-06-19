Shader "Unlit/ShaderTry"
{
	Properties
	{
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
				float4 c : COLOR;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 c : COLOR;
			};
			
			v2f vert (appdata input)
			{
				v2f output;
				output.vertex = UnityObjectToClipPos(input.vertex);
				output.c = input.c;			
				return output;
			}
			
			fixed4 frag (v2f input) : SV_Target
			{
				return input.c;
			}
			ENDCG
		}
	}
}
