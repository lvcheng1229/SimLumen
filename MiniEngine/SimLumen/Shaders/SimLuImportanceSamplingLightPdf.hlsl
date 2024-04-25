#define LIGHT_PDF_GROUP_SIZE 8

[numthreads(LIGHT_PDF_GROUP_SIZE, LIGHT_PDF_GROUP_SIZE, 1)]
void LightPdfCS(uint3 group_idx : SV_GroupID, uint3 group_thread_idx : SV_GroupThreadID)
{
    uint2 ss_probe_idx_xy = group_idx.xy;
    float probe_depth = probe_depth.Load(ss_probe_idx_xy);//todo:check valid

    if(probe_depth > 0)
    {

    }
}