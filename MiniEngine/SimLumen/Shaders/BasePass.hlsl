struct VSInput
{
    float3 position : POSITION;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
};

struct VSOutput
{
    float4 position : SV_POSITION;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
    float3 worldPos : TEXCOORD1;
};

cbuffer SLumenMeshConstants : register(b0)
{
    float4x4 WorldMatrix;   // Object to world
    float3x3 WorldIT;       // Object normal to world normal
    float4 color_multi;
};

cbuffer SLumenGlobalConstants : register(b1)
{
    float4x4 ViewProjMatrix;
    float3 CameraPos;
    float3 SunDirection;
    float3 SunIntensity;
}


VSOutput vs_main(VSInput vsInput, uint instanceID : SV_InstanceID)
{
    VSOutput vsOutput;

    float4 position = float4(vsInput.position, 1.0);
    float3 normal = vsInput.normal;

    vsOutput.worldPos = mul(WorldMatrix, position).xyz;
    vsOutput.position = mul(ViewProjMatrix, float4(vsOutput.worldPos, 1.0));
    vsOutput.normal = mul(WorldIT, normal);
    vsOutput.uv = vsInput.uv;
    return vsOutput;
}

Texture2D<float4> baseColorTexture          : register(t0);
SamplerState baseColorSampler               : register(s0);

float4 ps_main(VSOutput vsOutput) : SV_Target0
{
    float3 normal = vsOutput.normal;
    float2 tex_uv = vsOutput.uv;
    tex_uv.y = 1.0 - tex_uv.y;

    float4 baseColor = baseColorTexture.Sample(baseColorSampler, tex_uv);
    //return float4(baseColor.xyz * color_multi.xyz, 1.0);
    return float4(normal * 0.5 + 0.5, 1.0);
}