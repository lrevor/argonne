      SUBROUTINE MATGEN(PLEN, PNUM, PCOUNT, FLEN, FNUM, FMAX, WORDLEN, 
     1                  SCOUNT, PLIST, FRAG, TABLE, SEQ)

      INTEGER PLEN, PNUM, PCOUNT, FLEN, FNUM, FMAX, WORDLEN, SCOUNT
      INTEGER PLIST(0:PNUM), FRAG(FMAX), TABLE(PCOUNT, FMAX)
      INTEGER SEQ(SCOUNT)

      INTEGER LOOP, LOOP2

      DO 10 LOOP=1, FNUM
        DO 20 LOOP2=0, PNUM
          PLIST(LOOP2)=0
  20    CONTINUE
        CALL GET_LIST(PLEN, PNUM, FLEN, WORDLEN, PLIST, FRAG(LOOP), SEQ)
        CALL SET_BIT(TABLE(1,LOOP), PLIST, PNUM, WORDLEN)
  10  CONTINUE

      RETURN
      END
