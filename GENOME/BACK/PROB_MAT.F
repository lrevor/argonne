C     THIS SUBROUTINE IS TO GENERATE A TABLE OF POSITIVE OR NEGATIVE
C       RESULTS FROM THE MATCHING OF PROB'S TO FRAG'S.

      SUBROUTINE PROBMAT (PLEN, PNUM, FLEN, FNUM, MAXNUM, 
     1                   MAT_TAB, FRAG, PROB, SEQ)

      INTEGER PLEN, PNUM, FLEN, FNUM, I, J, POSIT
      LOGICAL MAT_TAB (MAXNUM, PNUM)
      INTEGER FRAG(FNUM)
      CHARACTER*(*) PROB, SEQ

c Initialize probe
      DO 200 I=1, PLEN
        PROB(I:I) = 'A'
  200  CONTINUE

c Outer loop goes through probes one at a time
      DO 300 I=1, PNUM
c Inner loop goes through the fragments to see if they contain the current
c probe.
       DO 100 J=1, FNUM
        POSIT = INDEX(SEQ(FRAG(J):FRAG(J)+FLEN-1), PROB(:PLEN))
        IF (POSIT .EQ. 0) THEN
          MAT_TAB(J,I) = .FALSE.
         ELSE
          MAT_TAB(J,I) = .TRUE.
        END IF
  100 CONTINUE
c Increment probe
      CALL PROB_GEN(PLEN, PROB)
  300 CONTINUE

      RETURN
      END
