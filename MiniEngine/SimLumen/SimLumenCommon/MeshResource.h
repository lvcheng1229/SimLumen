#pragma once
#include "SimLumenCommon.h"

struct SVolumeData
{
	SBox m_LocalSpaceBox;
	float m_VoxelSize = 4.0;//todo:fix bug
	std::vector<uint8_t> distance_filed_volume;
};

class CSimLumenMeshResouce
{
public:
	SVolumeData m_VolumeData;

	std::vector<DirectX::XMFLOAT3> m_positions;
	std::vector<DirectX::XMFLOAT3> m_normals;
	std::vector<DirectX::XMFLOAT2> m_uvs;
	std::vector<unsigned int> m_indices;

	Math::BoundingBox m_BoundingBox;

	Math::Matrix4 m_local_to_world;

	void LoadFrom(const std::string& source_file_an, const std::wstring& source_file, bool bforce_rebuild = false);
	void BuildMeshSDF();
	void BuildMeshCards();
};