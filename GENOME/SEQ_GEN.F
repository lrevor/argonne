C     THIS IS A SUBROUTINE TO GENERATE THE SEQUENCE RANDOMLY.

      SUBROUTINE SEQ_GEN (SEQ_LEN, ISEED, SEQ)

      INTEGER COUNT, SEQ_LEN, ISEED
      REAL VALUE, SEED
      CHARACTER*(*) SEQ

      SEED = RAND(ISEED)
      DO 10 COUNT = 1, SEQ_LEN

      SEED = RAND (0)
      VALUE = SEED * 4.0
      IF (VALUE .LE. 1.0) THEN
        SEQ(COUNT:COUNT) = 'A'
       ELSE IF (VALUE .LE. 2.0) THEN
        SEQ(COUNT:COUNT) = 'T'
       ELSE IF (VALUE .LE. 3.0) THEN
        SEQ(COUNT:COUNT) = 'G'
       ELSE 
        SEQ(COUNT:COUNT) = 'C'
      END IF

  10  CONTINUE

      RETURN
      END
