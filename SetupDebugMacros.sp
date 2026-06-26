#if !defined DEFAULT_DEBUG
  #error DEFAULT_DEBUG not set!!
  #endinput
#endif


#if defined _DEBUG
  #if _DEBUG==1
    #define DEBUG true
  #endif
#else
  #define DEBUG DEFAULT_DEBUG
#endif