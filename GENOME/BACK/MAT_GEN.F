C     THIS SUBROUTINE WILL GENERATE THE TABLE OF MATCHES BETWEEN PROB'S AND
C       FRAG'S

      SUBROUTINE MATGEN (PLEN, PNUM, FLEN, FNUM, MAT_TAB, FRAG)

      INTEGER PLEN, PNUM, FLEN, FNUM, COUNT, COUNT2, POSIT, POSIT2
      INTEGER BASECONV
      LOGICAL MAT_TAB(FNUM, PNUM)
      CHARACTER*(*) FRAG(FNUM)

c Outer loop goes through the fragments one at a time.  The inner loop goes
c through each fragment, copying out each prob-length section and converting
c it to a base-10 number, then marking the result in the table.
      DO 100 COUNT = 1, FNUM
       DO 100 COUNT2 = 1, (FLEN-PLEN+1)
        POSIT2 = COUNT2+PLEN-1
        POSIT = BASECONV(FRAG(COUNT)(COUNT2:POSIT2),PLEN)+1
        MAT_TAB(COUNT, POSIT) = .TRUE.
C       WRITE(*,*) FRAG(COUNT)(COUNT2:POSIT2), ' ', POSIT
  100 CONTINUE

      RETURN
      END
