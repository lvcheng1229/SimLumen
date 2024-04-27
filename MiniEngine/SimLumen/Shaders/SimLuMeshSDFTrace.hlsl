#define LIGHT_PROBE_TEX_SIZE 8
#include "SimLuSceneCommon.hlsl"
#include "SimSDFCommon.hlsl"

//b0 s0 and t1 are used for scene mesh sdf

StructuredBuffer<SMeshSDFInfo> scene_sdf_infos: register(t0);
Buffer<uint> probe_num_per_trace_type: register(t0);
Buffer<uint2> mesh_sdf_trace_probe_idx: register(t1);
Texture2D<float> probe_depth : register(t0);

Texture2D<uint> StructuredISIndirectTable: register(t0);



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

        uint ray_info = StructuredISIndirectTable.Load(probe_idx_xy);
        
        float2 probe_uv;
        RayTraceSingleMeshSDF(ray_info,probe_uv);
        float3 ray_direction = EquiAreaSphericalMapping(probe_uv);

        STraceResult trace_result;
        for(uint mesh_idx = 0; mesh_idx < scene_mesh_sdf_num; mesh_idx++)
        {
            RayTraceSingleMeshSDF(probe_world_pos,ray_direction,300,mesh_idx,trace_result);
        }

        if(trace_result.bHit)
        {
            
        }
    }
}

