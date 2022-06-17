      subroutine slave()

      INTEGER PLEN, PNUM
      PARAMETER (PLEN=6, PNUM=4095)

      INTEGER POSIT, EXT_LEN, PLIST(0:PNUM)
      INTEGER NEXT_POS(0:PNUM), FRAG
      INTEGER SUM(50), MASK, NEWPOS, TOTAL
      INTEGER POS_VEC(0:50)
      REAL TIME, TDUM

      INTEGER FROM, CODE, RECVLN, TYPE
      TIME = SECOND(TDUM)
      call receive(FROM,NEXT_POS,16384,RECVLN,TYPE,-1,-1,CODE)
  200 call receive(FROM,PLIST,16384,RECVLN,TYPE,-1,-1,CODE)

      IF (RECVLN.NE.4) THEN

        MASK=3

        DO 100 LOOP =1, 50
          SUM(LOOP)=0
  100    CONTINUE
        TOTAL = 0

        DO 500 POSIT=0, PNUM
         IF (PLIST(POSIT) .EQ. 1) THEN

          TOTAL = TOTAL+1

          NEWPOS=POSIT
          EXT_LEN=PLEN-1
  10      EXT_LEN=EXT_LEN+1

          SUM(EXT_LEN)=SUM(EXT_LEN)+1

          POS_VEC(EXT_LEN)=NEWPOS
          IF (EXT_LEN.GE.50) GO TO 40
          NEWPOS=NEXT_POS(NEWPOS)
      
  20      IF (PLIST(NEWPOS).EQ.1) GO TO 10

  30      NEWPOS=NEWPOS+1
          IF ((NEWPOS.AND.MASK).NE.0) GO TO 20

  40      NEWPOS=POS_VEC(EXT_LEN)
          EXT_LEN=EXT_LEN-1

          IF (EXT_LEN.GE.PLEN) GO TO 30

         END IF
  500   CONTINUE

        SUM(1) = TOTAL
        SUM(2) = SECOND(TDUM)-TIME
        call send(0,SUM,200,0,0,CODE)

        GO TO 200
      END IF

      CALL cleanup()
      STOP
      END
