#pragma once
#include "SimLumenCommon.h"

class CSimLumenMeshResouce
{
public:
	std::vector<DirectX::XMFLOAT3> m_positions;
	std::vector<DirectX::XMFLOAT3> m_normals;
	std::vector<DirectX::XMFLOAT2> m_uvs;
	std::vector<unsigned int> m_indices;

	Math::Matrix4 m_local_to_world;

	void LoadFrom(const std::string& source_file_an, const std::wstring& source_file, bool bforce_rebuild = false);
	void BuildMeshSDF();
	void BuildMeshCards();
};