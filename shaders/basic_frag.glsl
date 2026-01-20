#version 460

in vec2 texCoord;
in vec4 foliageColor;
in vec2 lightMapCoordinates;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 outColor0;

void main() {
  vec4 lightColor = texture(lightmap, lightMapCoordinates);
  vec4 outputColor = texture(gtexture, texCoord);
  if(outputColor.a < .1) discard;
  if(foliageColor.a > .1) outputColor *= foliageColor * lightColor;
  //if(foliageColor.a > .1) outputColor *= foliageColor;
  outColor0 = outputColor;
} 
