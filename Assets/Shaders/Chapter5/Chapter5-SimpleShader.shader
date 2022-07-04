// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity Shaders Book/Chapter 5/Simple Shader" {
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
	}
	SubShader {
        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            //暴露属性，名称与类型都要匹配
            uniform fixed4 _Color;
            //使用一个结构体来定义顶点着色器的输入
			struct a2v {
                //POSITION语义告诉 unity ，用模型空间的顶点坐标 填充 vertex变量
                float4 vertex : POSITION;
                //NORMAL语义告诉unity ，用模型空间的法线方向填充 normal变量
				float3 normal : NORMAL;
                //用模型的第一套纹理 填充。。。
				float4 texcoord : TEXCOORD0;
            };
            
            /*struct structname {
                type name : semantic;
            };*/
            //顶点着色器的输出
            struct v2f {
                // 在裁剪空间的坐标信息
                float4 pos : SV_POSITION;
                //颜色
                fixed3 color : COLOR0;
            };
            
            //传入 a2v参数
            v2f vert(a2v v) {
                //声明输出结构
            	v2f o;
                //坐标转换
            	o.pos = UnityObjectToClipPos(v.vertex);
                //fixed3 是相比于 float3 占用字节更短的 类型
                //颜色用 fixed3  位置用 float
                //将法线方向 归一化，并加上 0.5的V3
            	o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
                //将颜色映射到屏幕上，但是不改变A
            	fixed3 c = i.color;
                //使用Color属性控制输出颜色
            	c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG
        }
    }
}
