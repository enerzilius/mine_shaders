#version 460

in vec3 vaPosition;
in vec2 vaUV0;

out vec2 texCoord;

uniform vec3 chunkOffset;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

void main() {
  texCoord = vaUV0;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition+chunkOffset,1);
} 
