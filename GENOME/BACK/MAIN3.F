c This is the third version of the routine to generate the table of true
c false results for the genome project.  The table represents the result from
c checking to see if a given probe is contained in a given frag.  If this is
c true then the appropriate position in the table is marked.

      INTEGER COUNT, COUNT2, PNUM, M, MAXNUM, N, PLEN, SEQLEN
      INTEGER LOW, HIGH
      REAL SEED
      PARAMETER (N=1000, LOW=N/2, HIGH=N/2)
      PARAMETER (MAXNUM=100) 
      INTEGER FRAG(MAXNUM)
      PARAMETER (PLEN=6, PNUM=4096, SEQLEN=50500, SEED=0.45)
      CHARACTER MAT_OUT*101, SEQ*50500
      LOGICAL MAT_TAB(MAXNUM, PNUM)
C     DATA ((MAT_TAB(I,J),I=1,MAXNUM),J=1,PNUM) /11706368*.FALSE./

      REAL TDUM, T1, T2, SECOND

c M=Number of Fragments
c N=Length of the Fragments
c Maxnum = the maximum number of fragments possible
c ENDPT = see above
c Count, Count2 = loop variables
c Pnum = Number of probes (4**plen)
c Plen = length of the probes
c Seqlen = length of the sequence
c seed = seed for random number generator
c FRAG = list of the beginning position in the sequence for each probe
c Mat_out = a variable used to output the table
c seq = the actual sequence
c Mat_tab = the table that we are trying to generate
c TDUM, T1, T2, SECOND = variables and function used for timing.
c Low, High = variables for the recursive defintion of the starting point
c   of each of the fragments.  Each fragment starts between the low and
c   high position in the prior fragment randomly.  This allows for random
c   overlap.

      T1 = SECOND(TDUM)

      DO 900 COUNT=1, MAXNUM
       DO 900 COUNT2=1, PNUM
       MAT_TAB(COUNT,COUNT2) = .FALSE.
 900  CONTINUE

      CALL SEQ_GEN(SEQLEN, SEED, SEQ)
c This routine generates the actual sequence.  It is a character string
c that is filled with the letters A,T,C,G randomly

      CALL FRAG_GEN(M, MAXNUM, N, LOW, HIGH, FRAG, SEED, SEQLEN)
c This routine generates the beginning location of the fragments between
c the given boundaries Low and High.  Since each fragment starts in a 
c position that is dependant on the previous fragment, it is defined
c recursively.  The actual string is no longer copied out of the 
c sequence.  FRAG now only stores an integer pointing to the first
c character in the sequence that is contained by the fragment.

      CALL MATGEN (PLEN, PNUM, N, M, MAXNUM, MAT_TAB, FRAG, SEQ)
c This routine scans each fragment, pulling out each probe length section
c and using that to determine what probe that is and marking the appropriate
c spot in the table.  Since this only marks the true results, the table
c must be initialized before hand.  Since the actual fragments are no longer
c stored separately, it actual scans the sequence, but it scans the parts of
c the sequence that are logically the fragments.

      T2 = SECOND(TDUM) - T1

      WRITE(*,500) 'THE PROCESS TOOK ', T2, ' SECONDS'   
  500 FORMAT (A, F10.4, A)  
      
      OPEN (UNIT=1, FILE='seq3.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='seq3.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      WRITE(1,10) SEQ
      CLOSE(1)

      OPEN (UNIT=1, FILE='prob_match3.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='prob_match3.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      DO 110 COUNT=1, PNUM
        DO 120 COUNT2=1, M
          IF (MAT_TAB(COUNT2, COUNT)) THEN
            MAT_OUT(COUNT2:COUNT2)='T'
           ELSE
            MAT_OUT(COUNT2:COUNT2)='F'
          END IF
  120   CONTINUE
      WRITE(1,10) MAT_OUT
   10 FORMAT (A)
  110 CONTINUE
      CLOSE(1)

      OPEN (UNIT=1, FILE='frag3.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='frag3.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      DO 600 I = 1, M
      WRITE(1,*) SEQ(FRAG(I):FRAG(I)+N-1)
  600 CONTINUE
      CLOSE (1)

      T1 = SECOND(TDUM) - T2
      WRITE(*,500) 'WRITING THE FILES TOOK ', T1,' SECONDS'

      STOP
      END
