#version 460 compatibility

in vec4 blockColor;
in vec2 lightMapCoordinates;
in vec3 viewSpacePosition;
in vec3 geoNormal;

uniform sampler2D depthtex0;
uniform sampler2D lightmap;
uniform float viewWidth;
uniform float viewHeight;
uniform vec3 fogColor;
uniform mat4 gbufferModelViewInverse;
uniform vec3 shadowLightPosition;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 outColor0;

void main() {
  vec3 shadowDirection = normalize(mat3(gbufferModelViewInverse) * shadowLightPosition);
  vec3 worldGeoNormal = mat3(gbufferModelViewInverse) * geoNormal;
  float lightBrightness = clamp(dot(shadowDirection, worldGeoNormal), 0.2, 1.0);
  vec4 lightColor = pow(texture(lightmap, vec2(0.0, lightMapCoordinates.y)), vec4(2.2));
  vec4 outputColor = pow(blockColor, vec4(2.2));
  
  if(outputColor.a < .1) discard;
  
  vec2 depthTexCoords =  gl_FragCoord.xy / vec2(viewWidth, viewHeight);
  float depth = texture(depthtex0, depthTexCoords).r;
  
  if(depth != 1.0) discard;

  outputColor *= lightColor * lightBrightness;
  
  float distanceFromCamera = distance(vec3(0), viewSpacePosition);

  float maxFogDistance = 4000;
  float minFogDistance = 100;

  float fogBlendValue = clamp((distanceFromCamera - minFogDistance) / (maxFogDistance - minFogDistance), 0.0, 1.0);

  vec3 foggedOutputColor = mix(outputColor.rgb, pow(fogColor, vec3(2.2)), fogBlendValue);

  outColor0 = pow(vec4(foggedOutputColor, outputColor.a), vec4(1/2.2));
} 

