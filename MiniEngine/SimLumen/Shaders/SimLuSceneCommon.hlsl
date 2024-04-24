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

