#ifndef TEXTURE_H
#define TEXTURE_H

#include <GLES2/gl2.h>

GLuint LoadTexture(const char* assetPath);
void RenderTexture(GLuint texture, float x, float y, float width, float height);

#endif // TEXTURE_H