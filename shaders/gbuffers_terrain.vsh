#version 460

in vec3 vaPosition;
in vec2 vaUV0;

out vec2 texCoord;

uniform vec3 chunkOffset;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;


void main() {
  texCoord = vaUV0;

  vec3 worldPosition = cameraPosition + (gbufferModelViewInverse * modelViewMatrix * vec4(vaPosition+chunkOffset, 1)).xyz;
  float distance = distance(worldPosition, cameraPosition);
  gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition+chunkOffset,1);
} 
