c  This program os to generate statistics on the expansions of the
c   that takee place during the rebuilding of the fragments.  The data
c   that is wanted is to see how many fragments that are of length 10,
c   20, and 50 that are produced from the expansion of one probe.
c   Varying lengths of fragments (original) will be used.  This will be
c   done to see how the length of a fragment affects the possible
c   outcomes.

      SUBROUTINE STAT(PLEN, PNUM, PCOUNT, FMAX, FNUM, WORDSIZE, 
     1                TAB, PLIST)

      INTEGER PLEN, PNUM, PCOUNT, FMAX, FNUM, TAB(PCOUNT, FMAX)
      INTEGER PLIST(0:PNUM), WORDSIZE

      INTEGER COUNT, COUNT2, LOOP
      INTEGER SUM(5)
      INTEGER TOTAL

      COMMON SUM

      WRITE (*,50) '10', '20', '30', '40', '50',
     1             'TOTAL #'
  50  FORMAT (6A10)

c Establish outer loop.  This will go through the fragments one at a time.
      DO 550 COUNT=1, FNUM

c Zero accumulators.
      DO 100 LOOP =1, 5
        SUM(LOOP)=0
  100  CONTINUE
      TOTAL = 0

c Load the table data for the current fragment.
      CALL GET_BIT(TAB(1,COUNT), PLIST, PNUM, WORDSIZE)

C Establish inner loop.  This loop will expand starting with every probe
c   with a positive result in the table for the given fragment.
      DO 500 COUNT2=0, PNUM

      IF (PLIST(COUNT2) .EQ. 1) THEN

c Call the recursive routine for tracing the expansion tree.
        CALL NEXT(COUNT2, PLEN, PNUM, PLIST)
        TOTAL = TOTAL + 1
       END IF

  500 CONTINUE

c Print totals for fragment.
      WRITE (*,60) (SUM(LOOP), LOOP=1, 5), TOTAL
  60  FORMAT (6I10)

  550 CONTINUE

      RETURN
      END
