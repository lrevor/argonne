
      REAL S10, S20, S50, X10, X20, X50, TEN(31), TWENTY(31)
      REAL FIFTY(31), STD10, STD20, STD50, CI10, CI20, CI50
      REAL THIRTY(31), FOURTY(31), STD30, STD40, CI30, CI40
      REAL S30, S40, X30, X40
      INTEGER A, B, C, D, E, N, TOTAL

      OPEN (UNIT=1, FILE='stat.dat')

      N=0
      S10=0
      S20=0
      S30=0
      S40=0
      S50=0

  100 READ(1,10,END=110) A, B, C, D, E, TOTAL
  10  FORMAT(6I10)

      N=N+1
      TEN(N)=FLOAT(A)/TOTAL
      TWENTY(N)=FLOAT(B)/TOTAL
      THIRTY(N)=FLOAT(C)/TOTAL
      FOURTY(N)=FLOAT(D)/TOTAl
      FIFTY(N)=FLOAT(E)/TOTAL
      S10=S10+TEN(N)
      S20=S20+TWENTY(N)
      S30=S30+THIRTY(N)
      S40=S40+FOURTY(N)
      S50=S50+FIFTY(N)
      GO TO 100
  110 CONTINUE
      CLOSE(1)

      X10=S10/N
      X20=S20/N
      X30=S30/N
      X40=S40/N
      X50=S50/N

      S10=0
      S20=0
      S30=0
      S40=0
      S50=0

      DO 120 COUNT=1,N
      S10=S10+(X10-TEN(N))**2.0
      S20=S20+(X20-TWENTY(N))**2.0
      S30=S30+(X30-THIRTY(N))**2.0
      S40=S40+(X40-FOURTY(N))**2.0
      S50=S50+(X50-FIFTY(N))**2.0
  120 CONTINUE

      STD10 = SQRT(S10/(N-1))
      STD20 = SQRT(S20/(N-1))
      STD30 = SQRT(S30/(N-1))
      STD40 = SQRT(S40/(N-1))
      STD50 = SQRT(S50/(N-1))

      CI10 = 1.968*(STD10/SQRT(FLOAT(N)))
      CI20 = 1.968*(STD20/SQRT(FLOAT(N)))
      CI30 = 1.968*(STD30/SQRT(FLOAT(N)))
      CI40 = 1.968*(STD40/SQRT(FLOAT(N)))
      CI50 = 1.968*(STD50/SQRT(FLOAT(N)))

      WRITE(*,20) 'Mean', 'Stand. Dev', 'Confidence Interval'
  20  FORMAT(2A15, A20)
      WRITE(*,30) X10, STD10, CI10
      WRITE(*,30) X20, STD20, CI20
      WRITE(*,30) X30, STD30, CI30
      WRITE(*,30) X40, STD40, CI40
      WRITE(*,30) X50, STD50, CI50
  30  FORMAT(2F15.4,F20.4)

      CLOSE(1)
      STOP
      END
