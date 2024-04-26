#define LIGHT_PROBE_TEX_SIZE 32
#include "SimLuSceneCommon.hlsl"

StructuredBuffer<SMeshSDFInfo> scene_sdf_infos: register(t0);
Buffer<uint> probe_num_per_trace_type: register(t0);
Buffer<uint2> mesh_sdf_trace_probe_idx: register(t1);
Texture2D<float> probe_depth: register(t0);

void RayTraceSingleMeshSDF(float3 world_ray_start,float3 world_ray_direction,float min_trace_distance,float max_trace_distance, uint object_index)
{
    SMeshSDFInfo mesh_sdf_info = scene_sdf_infos[object_index];
    
    float3 world_ray_end = world_ray_start + world_ray_direction * max_trace_distance;
    float3 volume_ray_start = mul(mesh_sdf_info.world_to_volume,float4(world_ray_start,1.0)); //todo: is this valid?
    float3 volume_ray_end = mul(mesh_sdf_info.world_to_volume,float4(world_ray_end,1.0)); //todo: is this valid?

    
}

// probe num * 1 * 1
[numthreads(LIGHT_PROBE_TEX_SIZE, LIGHT_PROBE_TEX_SIZE, 1)]
void LightPdfCS(uint3 group_idx : SV_GroupID, uint3 group_thread_idx : SV_GroupThreadID)
{
    uint mesh_sdf_prob_num = probe_num_per_trace_type[0];
    if(group_idx.x < mesh_sdf_prob_num)
    {
        uint2 probe_idx_xy = mesh_sdf_trace_probe_idx[group_idx.x];
        float probe_depth = probe_depth.Load(probe_idx_xy);

        float3 probe_world_pos = ;


    }
}

