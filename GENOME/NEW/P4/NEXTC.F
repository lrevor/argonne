      subroutine fslave()

      INTEGER PLEN, PNUM
      PARAMETER (PLEN=6, PNUM=4095)

      INTEGER POSIT, EXT_LEN, PLIST(0:PNUM)
      INTEGER NEXT_POS(0:PNUM), FRAG
      INTEGER SUM(50), MASK, NEWPOS, TOTAL
      INTEGER POS_VEC(0:50)
      REAL TIME, TDUM, TIME2

      INTEGER FROM, CODE, RECVLN, TYPE
      COMMON SUM, TIME2

      TIME = SECOND(TDUM)
      TYPE = -1
      FROM = -1
      call p4recv(TYPE,FROM,NEXT_POS,16384,RECVLN,CODE)
      TYPE = -1
      FROM = -1
200    call p4recv(TYPE,FROM,PLIST,16384,RECVLN,CODE)

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
          IF (EXT_LEN.GE.30) GO TO 40
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
        TIME2 = SECOND(TDUM)-TIME
      call p4send(0,0,SUM,204,CODE)

        GO TO 200
      END IF

       call p4cleanup()
      STOP
      END
