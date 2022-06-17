C     THIS IS THE MAIN DRIVER PROGRAM
      include 'int_par.inc'
c
      INTEGER MAT_TAB(PCOUNT, MAXNUM)

      INTEGER FRAG(MAXNUM), NEXT_POS(0:PNUM), PLIST(0:PNUM)
      INTEGER COUNT, COUNT2, M
      REAL TDUM, T1, T2, SECOND

      call p4init()
      call p4crpg()

      T1 = SECOND(TDUM)

      DO 900 COUNT=1, MAXNUM
       DO 900 COUNT2=1, PCOUNT
       MAT_TAB(COUNT2,COUNT) = 0
 900  CONTINUE

      CALL SEQ_GEN(SCOUNT, SEQ, SEED, WRDLEN)
      CALL FRAG_GEN(M, MAXNUM, N, LOW, HIGH, FRAG, SEQLEN)

      CALL MATGEN (PLEN, PNUM, PCOUNT, N, M, MAXNUM, WRDLEN, SCOUNT,
     1             PLIST, FRAG, MAT_TAB, SEQ)

      T2 = SECOND(TDUM) - T1

      CALL STAT(PLEN, PNUM, PCOUNT, MAXNUM, M, NEXT_POS, MAT_TAB,
     1          PLIST, WRDLEN)

      T1 = SECOND(TDUM) - T2 - T1

      WRITE(*,500) 'THE GENERATION TOOK ', T2, ' SECONDS'   
      WRITE(*,500) 'THE CONSTRUCTION TOOK ', T1,' SECONDS'
  500 FORMAT (A, F10.4, A)  
      
       call p4cleanup()

c     OPEN (UNIT=1, FILE='seq3.dat')
c     CLOSE (1, STATUS='DELETE')
c     OPEN (UNIT=1, FILE='seq3.dat', ACCESS='SEQUENTIAL',
c    1      FORM='FORMATTED', STATUS='NEW')
c     WRITE(1,10) SEQ
c     CLOSE(1)

c     OPEN (UNIT=1, FILE='table.dat')
c     CLOSE (1, STATUS='DELETE')
c     OPEN (UNIT=1, FILE='table.dat', ACCESS='SEQUENTIAL',
c    1      FORM='FORMATTED', STATUS='NEW')
c     WRITE (1,10) PCOUNT
c     WRITE (1,10) M
c  10 FORMAT (I1)
c     DO 100 COUNT=1, M
c       WRITE (1,10) (MAT_TAB(COUNT2, COUNT),COUNT2=1,PCOUNT)
c 100  CONTINUE
c     CLOSE(1)

c     OPEN (UNIT=1, FILE='frag3.dat')
c     CLOSE (1, STATUS='DELETE')
c     OPEN (UNIT=1, FILE='frag3.dat', ACCESS='SEQUENTIAL',
c    1      FORM='FORMATTED', STATUS='NEW')
c     DO 600 I = 1, M
c     WRITE(1,*) SEQ(FRAG(I):FRAG(I)+N-1)
c 600 CONTINUE
c     CLOSE (1)

      STOP
      END
