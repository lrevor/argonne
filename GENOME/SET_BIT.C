set_bit_(table, vec, pnum, word_size)
   int *table, *vec, *pnum, *word_size;
{
   int loop, *temp, x, y;
   for(loop=0;loop<=*pnum;loop++) {
     if (*vec == 1) {
     x=loop / *word_size;
     y=loop  % *word_size;
     temp = table+x;
     *temp |= (1<<y);
     }
     vec++;
    }
}
