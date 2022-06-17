long mclock_()
  {
  long  buf[4];
  times(buf);
  return(buf[0]);
  }
