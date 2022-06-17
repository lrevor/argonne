      SUBROUTINE STAT(PLEN, PNUM, PCOUNT, FMAX, FNUM, NEXT_POS, TAB,
     1                PLIST, WORDSIZE)

      INTEGER PLEN, PNUM, PCOUNT, FMAX, FNUM, TAB(PCOUNT, FMAX)
      INTEGER NEXT_POS(0:PNUM), PLIST(0:PNUM), WORDSIZE

      INTEGER POSIT, LOOP, MASK, SUM(50), NUM, CODE, FROM
      INTEGER TYPE, RECVLN
      REAL TIME
      COMMON SUM, TIME

      call p4nslaves(NUM)
      write(*,*) 'SLAVES - ', NUM
      WRITE (*,50) '10', '20', '30', '40', '50',
     1             'TOTAL #'
  50  FORMAT (6A10)

      MASK=4**(PLEN-1)-1
      DO 10 LOOP=0, PNUM
        NEXT_POS(LOOP)=(LOOP.AND.MASK)*4
  10  CONTINUE

      DO 20 LOOP=1, NUM
      call p4send(0,LOOP,NEXT_POS,16384,CODE)
  20  CONTINUE

      IF (FNUM.LT.NUM) NUM=FNUM

      DO 550 POSIT=1, NUM

        CALL GET_BIT(TAB(1,POSIT), PLIST, PNUM, WORDSIZE)
      call p4send(0,POSIT,PLIST,16384,CODE)

  550 CONTINUE

      DO 560 POSIT=NUM+1, FNUM
      TYPE = -1
      FROM = -1
      call p4recv(TYPE,FROM,SUM,204,RECVLN,CODE)
        CALL GET_BIT(TAB(1,POSIT), PLIST, PNUM, WORDSIZE)
      call p4send(0,FROM,PLIST,16384,CODE)
        WRITE (*,60) (SUM(LOOP), LOOP=10, 50, 10), SUM(1)
  60    FORMAT (6I10)
  560 CONTINUE

      DO 570 POSIT=1, NUM
      TYPE = -1
      FROM = -1
      call p4recv(TYPE,FROM,SUM,204,RECVLN,CODE)
        WRITE (*,60) (SUM(LOOP), LOOP=10, 50, 10), SUM(1)
  570 CONTINUE

      call p4nslaves(NUM)
      DO 30 LOOP=1, NUM
      call p4send(0,LOOP,NUM,4,CODE)
  30  CONTINUE

      WRITE (*,70) 'THE MAX SLAVE TIME IS : ', TIME
  70  FORMAT (A,F10.4)
      RETURN
      END
