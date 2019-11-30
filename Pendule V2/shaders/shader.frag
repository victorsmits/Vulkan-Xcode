#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 1) uniform sampler2D texSampler;
layout(binding = 2) uniform sampler2D normSampler;

layout(location = 0) in vec3 fragNormal;
layout(location = 1) in vec2 fragTexCoord;
layout(location = 2) in vec3 lightDir;
layout(location = 3) in vec3 reflectDir;
layout(location = 4) in vec3 cameraDir;
layout(location = 5) in vec3 fragTangent;

layout(location = 0) out vec4 outColor;

void main() {

	vec3 normal = normalize(fragNormal);
	vec3 tangent = normalize(fragTangent);
	vec3 binormal = normalize(cross(normal, tangent));
	mat3 TBN = mat3(tangent, binormal, normal);
	vec3 theNormal = TBN * normalize(texture(normSampler, fragTexCoord).rgb * 2 - 1.0);
	vec3 light = normalize(lightDir);
	vec3 refl = normalize(-reflect(light, theNormal));
	vec3 cam = normalize(cameraDir);
	outColor = clamp(max(dot(theNormal, light), 0.4) * texture(texSampler, fragTexCoord) + pow(max(dot(refl, cam), 0.0), 20)*vec4(1.0), 0.0, 1.0);
}