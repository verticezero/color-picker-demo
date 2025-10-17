float3 gColor;

float4 Pixel(float2 uv : TEXCOORD0) : COLOR0 {

	float3 color = float3(1.0, 1.0, 1.0);
	color = lerp(color, gColor, uv.x);
	color = lerp(color, float3(0.0, 0.0, 0.0), uv.y);

	return float4(color, 1);
}

technique complercated {
	pass P0 {
		PixelShader = compile ps_2_0 Pixel();
	}
}

technique fallback {pass P0 {}}