#include "utils.h"
#include <android/log.h>
#include <sys/time.h>
#include <time.h>

void Log(const char* fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    __android_log_vprint(ANDROID_LOG_INFO, "xmake-androidcpp", fmt, args);
    va_end(args);
}
