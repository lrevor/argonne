get_bit_(table, vec,  pnum, word_size)
 int *table, *vec,  *pnum, *word_size;
{
  int loop, x, y, temp;

   for (loop=0; loop<= *pnum; loop++) {
     x=loop / *word_size;
     y=loop % *word_size;
     temp= *(table+x);
     temp &= (1<<y);
     if (temp!=0) *vec=1;
     else *vec=0;
     vec+=1;
    }
}
