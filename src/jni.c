#include <unistd.h>
#include <errno.h>
#include <dlfcn.h>
#include <stdio.h>

#ifdef JNI
#include <jni.h>
#include <android/log.h>
#endif

JNIEXPORT jint JNICALL Java_net_commotionwireless_olsrd_Olsrd_main(JNIEnv *env, jobject this, jobjectArray args) {
  void *dlhandle;
  int (*jni_main_fun)(JNIEnv *, jobject, jobjectArray);
  dlhandle = dlopen("/data/data/net.commotionwireless.meshtether/app_bin/libolsrd.so", RTLD_GLOBAL|RTLD_NOW);
  if (dlhandle == NULL) {
    const int save_errno = errno;
    const char *err = dlerror();
    printf("DL loading failed: %s\n", err);
    errno = save_errno;
    return -1;
  }
  jni_main_fun = dlsym(dlhandle, "jni_main");
  return jni_main_fun(env, this, args);
}
