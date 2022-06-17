c  This program os to generate statistics on the expansions of the
c   that takee place during the rebuilding of the fragments.  The data
c   that is wanted is to see how many fragments that are of length 10,
c   20, and 50 that are produced from the expansion of one probe.
c   Varying lengths of fragments (original) will be used.  This will be
c   done to see how the length of a fragment affects the possible
c   outcomes.

      INTEGER PLEN, PNUM, FMAX, FNUM
      PARAMETER (PLEN=6, PNUM=4095, FMAX=100)

      LOGICAL TAB(0:PNUM,FMAX)

      INTEGER COUNT, COUNT2, TEN, TWENTY, THIRTY
      INTEGER FOURTY, FIFTY
      INTEGER TOTAL
      CHARACTER TEMP*101

      REAL TDUM, T1, T2, SECOND

      COMMON TEN, TWENTY, THIRTY, FOURTY, FIFTY

C Read in the table of data.
      OPEN(UNIT=1, FILE='table.dat')

      READ(1,10) TEMP
  10  FORMAT(A)
      FNUM=INDEX(TEMP,' ')-1
      DO 100 COUNT2=1, FNUM
        IF (TEMP(COUNT2:COUNT2) .EQ. 'T') THEN
          TAB(0,COUNT2) = .TRUE.
         ELSE
          TAB(0,COUNT2) = .FALSE.
        END IF
  100 CONTINUE

      DO 110 COUNT=1, PNUM
      READ(1,10) TEMP
      DO 110 COUNT2=1, FNUM
        IF (TEMP(COUNT2:COUNT2) .EQ. 'T') THEN
          TAB(COUNT,COUNT2) = .TRUE.
         ELSE
          TAB(COUNT,COUNT2) = .FALSE.
        END IF
  110 CONTINUE

      CLOSE(1)

      WRITE (*,50) '10', '20', '30', '40', '50',
     1             'TOTAL #'
  50  FORMAT (6A10)

c Initialize timing routine.
      T1 = SECOND(TDUM)

c Establish outer loop.  This will go through the fragments one at a time.
      DO 550 COUNT=1, FNUM

c Zero accumulators.
      TEN = 0
      TWENTY = 0
      THIRTY = 0
      FOURTY = 0
      FIFTY = 0
      TOTAL = 0

C Establish inner loop.  This loop will expand starting with every probe
c   with a positive result in the table for the given fragment.
      DO 500 COUNT2=0, PNUM

      IF (TAB(COUNT2,COUNT))  THEN

c Call the recursive routine for tracing the expansion tree.
        CALL NEXT(COUNT2, COUNT, PLEN, TAB, PNUM, FMAX)
c       WRITE(*,*) TEN, TWENTY, THIRTY, FOURTY, FIFTY
        TOTAL = TOTAL + 1
       END IF

  500 CONTINUE

c Print totals for fragment.
      WRITE (*,60) TEN, TWENTY, THIRTY, FOURTY, FIFTY, TOTAL
  60  FORMAT (6I10)

  550 CONTINUE

      T2 = SECOND(TDUM) - T1
      WRITE(*,70) 'THE PROCESS TOOK ', T2, ' SECONDS'
  70  FORMAT (A,F10.2,A)

      STOP
      END
