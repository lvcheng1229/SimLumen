struct SSimLuDirectionalLight
{
    float3 SunDirection;
    float3 SunIntensity;
};

struct SSimLuMeshCard
{
    uint card_start_index;
};

struct SSimLuCard
{
    float3x3 mesh_card_l2w_rotation;
    float3x3 l2w_rotation;

    uint2 atlas_card_index;
    uint mesh_card_index;
    uint card_dir_index;
};

struct SSimLuSurfaceCacheData
{
    bool valid;
    float3 albedo;

    float3 world_position;
    float3 world_normal;
};


struct SMeshSDFInfo
{
    float4x4 volume_to_world;
    float4x4 world_to_volume;

    float3 volume_position_extent;

}

float Luminance( float3 color )
{
	return dot( color, float3( 0.3, 0.59, 0.11 ) );
}

uint PackRayInfo(uint2 TexelCoord, uint Level)
{
	// Pack in 16 bits
	return (TexelCoord.x & 0x3F) | ((TexelCoord.y & 0x3F) << 6) | ((Level & 0xF) << 12);
}

void UnpackRayInfo(uint RayInfo, out uint2 TexelCoord, out uint Level)
{
	TexelCoord.x = RayInfo & 0x3F;
	TexelCoord.y = (RayInfo >> 6) & 0x3F;
	Level = (RayInfo >> 12) & 0xF;
}

// Based on: [Clarberg 2008, "Fast Equal-Area Mapping of the (Hemi)Sphere using SIMD"]
// Fixed sign bit for UV.y == 0 and removed branch before division by using a small epsilon
// https://fileadmin.cs.lth.se/graphics/research/papers/2008/simdmapping/clarberg_simdmapping08_preprint.pdf
float3 EquiAreaSphericalMapping(float2 UV)
{
	UV = 2 * UV - 1;
	float D = 1 - (abs(UV.x) + abs(UV.y));
	float R = 1 - abs(D);
	// Branch to avoid dividing by 0.
	// Only happens with (0.5, 0.5), usually occurs in odd number resolutions which use the very central texel
	float Phi = R == 0 ? 0 : (PI / 4) * ((abs(UV.y) - abs(UV.x)) / R + 1);
	float F = R * sqrt(2 - R * R);
	return float3(
		F * sign(UV.x) * abs(cos(Phi)),
		F * sign(UV.y) * abs(sin(Phi)),
		sign(D) * (1 - R * R)
	);
}