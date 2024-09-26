#include "game.h"
#include "texture.h"
#include "init.h"

GLuint t_xmake_logo;

float ScaleX(float percent)
{
    return (percent / 100.0f) * WindowSizeX;
}

float ScaleY(float percent)
{
    return (percent / 100.0f) * WindowSizeY;
}

bool InitGame()
{
    t_xmake_logo = LoadTexture("xmake-logo.png");
    return true;
}

void Render()
{
    //background
    RenderTexture(t_xmake_logo, (WindowSizeX - 100) / 2, (WindowSizeY - 100) / 2, 100, 100);
}

void ShutdownGame()
{
    glDeleteTextures(1, &t_xmake_logo);
}