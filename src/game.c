#include "android_native_app_glue.h"
#include <GLES2/gl2.h>
#include "game.h"
#include "utils.h"
#include "texture.h"
#include "init.h"
#include "mouse.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define SIZE_SPACE_PIPE 3.3f

#define SPACE_BETWEEN_PIPES 5

GLuint t_background_day;

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
    t_background_day = LoadTexture("sprites/background-day.png");
    return true;
}

void Render()
{
    //background
    RenderTexture(t_background_day, 0, 0, ScaleX(100), ScaleY(95.83));
}

void ShutdownGame()
{
    glDeleteTextures(1, &t_background_day);
}