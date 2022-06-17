get_bit_(table, vec,  pnum, word_size)
 int *table, *vec,  *pnum, *word_size;
{
  int loop, x, y, temp, *hold;

   for (loop=0; loop<= *pnum; loop++) {
     x=loop / *word_size;
     y=loop % *word_size;
     hold=table+x;
     temp=*hold;
     temp &= (1<<y);
     if (temp!=0) *vec=1;
     else *vec=0;
     vec+=1;
    }
}
