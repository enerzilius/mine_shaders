#version 460 compatibility

in vec2 texCoord;
in vec4 foliageColor;
in vec2 lightMapCoordinates;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 outColor0;

void main() {
  vec4 lightColor = pow(texture(lightmap, lightMapCoordinates), vec4(2.2));;
  vec4 outputColor = pow(texture(gtexture, texCoord), vec4(2.2));
  if(outputColor.a < .1) discard;
  if(foliageColor.a > .1) outputColor *= pow(foliageColor,vec4(2.2)) * lightColor;

  outColor0 = pow(outputColor, vec4(1/2.2));
} 
