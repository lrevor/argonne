      PROGRAM NEXT

      include 'fcube.h'

      INTEGER PLEN, PNUM
      PARAMETER (PLEN=6, PNUM=4095)

      INTEGER POSIT, EXT_LEN, PLIST(0:PNUM)
      INTEGER NEXT_POS(0:PNUM), FRAG
      INTEGER SUM(50), MASK, NEWPOS, TOTAL
      INTEGER POS_VEC(0:50)
      INTEGER HOST, TIME

      HOST = myhost()
      CALL CRECV(0, NEXT_POS, 16384)
      TIME = MCLOCK()
  200 CALL CRECV(0, PLIST, 16384)

      MASK=3

      DO 100 LOOP =1, 50
        SUM(LOOP)=0
  100  CONTINUE
      TOTAL = 0

      DO 500 POSIT=0, PNUM
       IF (PLIST(POSIT) .EQ. 1) THEN

        TOTAL = TOTAL+1

        NEWPOS=POSIT
        EXT_LEN=PLEN-1
  10    EXT_LEN=EXT_LEN+1

        SUM(EXT_LEN)=SUM(EXT_LEN)+1

        POS_VEC(EXT_LEN)=NEWPOS
        IF (EXT_LEN.GE.30) GO TO 40
        NEWPOS=NEXT_POS(NEWPOS)
      
  20    IF (PLIST(NEWPOS).EQ.1) GO TO 10

  30    NEWPOS=NEWPOS+1
        IF ((NEWPOS.AND.MASK).NE.0) GO TO 20

  40    NEWPOS=POS_VEC(EXT_LEN)
        EXT_LEN=EXT_LEN-1

        IF (EXT_LEN.GE.PLEN) GO TO 30

       END IF
  500 CONTINUE

      SUM(1) = TOTAL
      SUM(2) = MYNODE()
      SUM(3) = MCLOCK() - TIME
      CALL CSEND(0,SUM,200,HOST,100)

      GO TO 200
      END
