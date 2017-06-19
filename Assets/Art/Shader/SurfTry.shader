Shader "Custom/SurfTry" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		_SubTex ("Texture", 2D) = "white" {}
		_Blend ("Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SubTex;
		sampler2D _Blend;

		struct Input {
			float2 uv_MainTex;
			float2 uv_SubTex;
			float2 uv_Blend;
		};

		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input input, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			//fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;


			fixed4 colMain = tex2D(_MainTex, input.uv_MainTex);
			fixed4 colSub = tex2D(_SubTex, input.uv_SubTex);

			float mat = tex2D(_Blend, input.uv_Blend).r;

			fixed4 cG = colMain * mat;
			fixed4 cB = colSub * (1- mat);

			o.Albedo = (cG + cB);

		}
		ENDCG
	}
	FallBack "Diffuse"
}
