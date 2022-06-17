C     THIS SUBROUTINE WILL GENERATE THE TAKE OF MATCHES BETWEEN PROB'S AND
C       FRAG'S

      SUBROUTINE MATGEN (PLEN, PNUM, FLEN, FNUM, MAXNUM, 
     1                   MAT_TAB, FRAG, SEQ)

      INTEGER PLEN, PNUM, FLEN, FNUM, COUNT, COUNT2
      INTEGER BASECONV, FRAG(FNUM), POSIT, POSIT1, POSIT2
      LOGICAL MAT_TAB(MAXNUM, PNUM)
      CHARACTER*(*) SEQ

c Outer loop goes through the fragments one at a time.  The inner loop goes
c through each fragment, copying out each prob-length section and converting
c it to a base-10 number, then marking the result in the table.
      DO 100 COUNT = 1, FNUM
       DO 100 COUNT2 = 1, (FLEN-PLEN+1)
        POSIT1 = FRAG(COUNT)+COUNT2-1
        POSIT2 = POSIT1+PLEN-1
        POSIT = BASECONV(SEQ(POSIT1:POSIT2),PLEN)+1
        MAT_TAB(COUNT, POSIT) = .TRUE.
  100 CONTINUE

      RETURN
      END
