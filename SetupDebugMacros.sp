#if !defined _DEBUG
  #define _DEBUG 0
#endif

#define NDEBUG (defined _DEBUG && (_DEBUG==0))
#define DEBUG  (defined _DEBUG && (_DEBUG==1))