      SUBROUTINE STAT(PLEN, PNUM, PCOUNT, FMAX, FNUM, NEXT_POS, TAB,
     1                PLIST, WORDSIZE)

      INTEGER PLEN, PNUM, PCOUNT, FMAX, FNUM, TAB(PCOUNT, FMAX)
      INTEGER*4 NEXT_POS(0:PNUM), PLIST(0:PNUM)
      INTEGER WORDSIZE

      INTEGER POSIT, LOOP, MASK, SUM(50), NUM, NUMTMP

      NUM=NUMNODES()
      NUMTMP=NUM
      WRITE (*,50) '10', '20', '30', '40', '50',
     1             'TOTAL #'
  50  FORMAT (6A10)

      MASK=4**(PLEN-1)-1
      DO 10 LOOP=0, PNUM
        NEXT_POS(LOOP)=(LOOP.AND.MASK)*4
  10  CONTINUE

      DO 20 LOOP=1, NUM-1
      CALL CSEND(0, NEXT_POS, 16384, LOOP, 0)
  20  CONTINUE

      IF (FNUM.LT.NUM) NUM=FNUM

      DO 550 POSIT=1, NUM-1

        CALL GET_BIT(TAB(1,POSIT), PLIST, PNUM, WORDSIZE)
        CALL CSEND(0, PLIST, 16384, POSIT, 0)

  550 CONTINUE

      DO 560 POSIT=NUM, FNUM
        CALL CRECV(0, SUM, 200)
        CALL GET_BIT(TAB(1,POSIT), PLIST, PNUM, WORDSIZE)
        CALL CSEND(0, PLIST, 16384, SUM(2), 0)
        WRITE (*,60) (SUM(LOOP), LOOP=10, 50, 10), SUM(1)
  60    FORMAT (6I10)
  560 CONTINUE

      DO 570 POSIT=1, NUM-1
        CALL CRECV(0, SUM, 200)
        WRITE (*,60) (SUM(LOOP), LOOP=10, 50, 10), SUM(1)
  570 CONTINUE

      NUM = NUMTMP
      PLIST(0)=-1
      DO 600 LOOP = 1, NUM-1
        CALL CSEND(0,PLIST,16384,LOOP,0)
  600 CONTINUE

      WRITE (*,70) 'THE MAX GAMMA NODE TIME IS : ', SUM(3)
  70  FORMAT (A,I10)

      RETURN
      END
