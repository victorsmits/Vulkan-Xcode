#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 0) uniform UniformBufferObject {
	mat4 model;
	mat4 view;
	mat4 proj;
	vec3 lightPos;
} ubo;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inNormal;
layout(location = 2) in vec3 inTangent;
layout(location = 3) in vec2 inTexCoord;

layout(location = 0) out vec3 fragNormal;
layout(location = 1) out vec2 fragTexCoord;
layout(location = 2) out vec3 lightDir;
layout(location = 3) out vec3 reflectDir;
layout(location = 4) out vec3 cameraDir;
layout(location = 5) out vec3 fragTangent;


void main() {
	gl_PointSize = 5.0;
	gl_Position = ubo.proj * ubo.view * ubo.model * vec4(inPosition, 1.0);
	fragNormal = vec3(ubo.model * vec4(inNormal, 1.0));
	vec3 pos = vec3(ubo.model * vec4(inPosition, 1.0));
	lightDir = normalize(ubo.lightPos - pos);
	reflectDir = -reflect(lightDir, fragNormal);
	vec3 cameraPos = vec3(inverse(ubo.view) * vec4(0.0, 0.0, 0.0, 1.0));
	cameraDir = cameraPos - pos;
	fragTexCoord = inTexCoord;
	fragTangent = vec3(ubo.model * vec4(inTangent, 1.0));
}