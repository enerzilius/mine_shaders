#version 460 compatibility

out vec4 blockColor;
out vec2 lightMapCoordinates;
out vec3 viewSpacePosition;
out vec3 geoNormal;

uniform mat4 dhProjection;

void main() {
  blockColor = gl_Color;
  lightMapCoordinates = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
  viewSpacePosition = (gl_ModelViewMatrix * gl_Vertex).xyz;
  geoNormal = gl_NormalMatrix * gl_Normal;


  gl_Position = ftransform();
}

