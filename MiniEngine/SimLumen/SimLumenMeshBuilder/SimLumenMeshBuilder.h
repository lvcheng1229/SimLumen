#pragma once
#include "../SimLumenCommon/MeshResource.h"

class CSimLumenMeshBuilder
{
public:
	void Init();
	void Destroy();

	// Create Mesh Bound
	void BuildMesh(CSimLumenMeshResouce& mesh);
private:
	void* m_RtDevie;
};