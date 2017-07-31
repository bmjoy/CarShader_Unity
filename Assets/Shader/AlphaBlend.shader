Shader "Alpha Blend" {
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Main Tex", 2D) = "white" {}
		_AlphaScale ("Alpha Scale", Range(0, 1)) = 0.2//调整整体的透明度
	}
	SubShader {
		Tags {
			"Queue"="Transparent" 
			"IgnoreProjector"="True" //不受投影器影响
			"RenderType"="Transparent"}//着色器替换
		Pass {
			Tags { "LightMode"="ForwardBase" }//按照前向渲染路径提供各个光照变量
			ZWrite Off//关闭深度写入
			Blend SrcAlpha OneMinusSrcAlpha//设置pass的混合模式，SrcAlpha为混合因子
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Lighting.cginc"
			fixed4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed _AlphaScale;
			
			struct a2v {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
			};
			
			struct v2f {
				float4 pos : SV_POSITION;//存放模型顶点在投影空间的坐标
				float3 worldNormal : TEXCOORD0;
				float3 worldPos : TEXCOORD1;
				float2 uv : TEXCOORD2;
			};
			v2f vert(a2v v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				//计算世界空间的法线方向
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				//计算世界空间的顶点坐标
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				//变换后的纹理坐标
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target {
				fixed3 worldNormal = normalize(i.worldNormal);

				fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
				
				fixed4 texColor = tex2D(_MainTex, i.uv);
				
				fixed3 albedo = texColor.rgb * _Color.rgb;
				
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
				
				//计算环境光照和漫反射光照
				fixed3 diffuse = _LightColor0.rgb * albedo * max(0, dot(worldNormal, worldLightDir));

				//设置返回值中的透明通道
				return fixed4(ambient + diffuse, texColor.a * _AlphaScale);
			}
			
			ENDCG
		}
	} 
	FallBack "Transparent/VertexLit"
}
