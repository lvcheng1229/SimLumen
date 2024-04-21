#include "SimLumenCommon.h"

static SLumenConfig* config = nullptr;


SLumenConfig GetLumenConfig()
{
	if (config)
	{
		return *config;
	}
	
	config = new SLumenConfig();
	config->m_LightDirection = Normalize(Math::Vector3(-1, 1, -1));
}
