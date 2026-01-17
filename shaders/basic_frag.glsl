#version 460

in vec2 texCoord;
in vec4 foliageColor;

uniform sampler2D gtexture;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 outColor0;

void main() {
  vec4 outputColor = texture(gtexture, texCoord);
  outputColor *= foliageColor;

  if(outputColor.a < .1) discard;
  outColor0 = outputColor;
} 
