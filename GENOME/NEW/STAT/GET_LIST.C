get_list_(plen, pnum, flen, wordsize, plist, start, seq)

int *plen, *pnum, *flen, *wordsize;
int *plist, *start, *seq;

{
  int loop;
  int x, y, temp, probe, mask;

    probe=0;
    x=((*start-1)*2) / (*wordsize-2);
    y=((*start-1)*2) % (*wordsize-2);
    for(loop=1; loop < *plen; loop++) {
      probe = probe<<2;
      temp=*(seq+x);
      temp = temp >> y;
      temp &= 3;
      probe |= temp;
      if (y==(*wordsize-4)) {
        x+=1;
        y=0;
        }
      else y+=2;
      }
    mask= (1<<(2*(*plen-1)))-1;
    for(loop=1; loop <= (*flen-*plen+1); loop++) {
      probe &= mask;
      probe = probe << 2;
      temp=*(seq+x);
      temp = temp >> y;
      temp &= 3;
      probe |= temp;
      *(plist+probe) = 1;
      if (y==(*wordsize-4)) {
        x+=1;
        y=0;
        }
      else y+=2;
      }
  }
