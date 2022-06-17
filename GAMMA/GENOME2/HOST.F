      include 'fcube.h'

      INTEGER NUM, COUNT
      CALL SETPID(100)
      NUM=NUMNODES()
      CALL LOAD('gen',0,0)
      DO 10 COUNT=1, NUM-1
      CALL LOAD('next',COUNT,0)
  10  CONTINUE

      CALL CRECV(0,TEMP,4)

      CALL KILLCUBE(-1,0)
      WRITE(*,*) 'KILLING CUBE -- FINISHED'
      STOP
      END
