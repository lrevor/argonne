
      CHARACTER*1 FUNCTION BUMP (IN)

      CHARACTER IN*1
      
      IF (IN .EQ. 'A') THEN
        BUMP = 'T'
       ELSE IF (IN .EQ. 'T') THEN
        BUMP = 'C'
       ELSE
        BUMP = 'G'
      ENDIF

      RETURN
      END

c This routine accepts a character probe as input and returns the next
c probe in the series.

      SUBROUTINE PROB_GEN (PLEN, PROB)

      INTEGER PLEN, I, J
      CHARACTER*1 PROB(PLEN), BUMP



      I=PLEN

  100 IF (PROB(I) .EQ.  'G') THEN
        I = I - 1
        GOTO 100
       END IF

      PROB(I) = BUMP(PROB(I))
      DO 110 J=I+1, PLEN
        PROB(J) = 'A'
  110 CONTINUE

      RETURN
      END

