c  this subroutine is to take a base 10 number and to convert it to a
c  base four number then translating it into the genetic numbers.

      SUBROUTINE CONVERT(CURRENT, OUTSTR, PLEN)

      INTEGER INNUM, PLEN, I, CURRENT
      CHARACTER*(*) OUTSTR

      INNUM = CURRENT - 1

      DO 100 I=PLEN-1, 0, -1
      TEMP = 4**I
      IF (INNUM .GE. (TEMP*3)) THEN 
        OUTSTR(PLEN-I:PLEN-I) = 'G'
        INNUM=INNUM-(TEMP*3)
       ELSE
        IF (INNUM .GE. (TEMP*2)) THEN
          OUTSTR(PLEN-I:PLEN-I) = 'C'
          INNUM=INNUM-(TEMP*2)
         ELSE
          IF (INNUM .GE. (TEMP)) THEN
            OUTSTR(PLEN-I:PLEN-I) = 'T'
            INNUM=INNUM-(TEMP)
           ELSE
            OUTSTR(PLEN-I:PLEN-I) = 'A'
          END IF
        END IF
      END IF
  100 CONTINUE
      RETURN
      END
