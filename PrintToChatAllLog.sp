void PrintToChatAllLog(const char[] msgRaw, any ...)
{
  char msg[1280];
  VFormat(msg, sizeof(msg), msgRaw, 2);

  PrintToChatAll(msg);
  LogMessage(msg);
}