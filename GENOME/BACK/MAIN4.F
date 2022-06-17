c This is the fourth version of the routine to generate the table of true
c false results for the genome project.  The table represents the result from
c checking to see if a given probe is contained in a given frag.  If this is
c true then the appropriate position in the table is marked.

c This version is a combination of the previous versions.  It was written for 
c comparison.  It actually copies the fragments out of the sequence, and
c it checks physically checks to see if every probe is in every fragment.
c It does not generate and store every probe.  It keeps a current probe and
c updates it every time through the loop.

      INTEGER COUNT, COUNT2, PNUM, M, MAXNUM, N, PLEN, SEQLEN
      PARAMETER (MAXNUM=100)
      INTEGER FRAG(MAXNUM), LOW, HIGH
      PARAMETER (N=1000, LOW=N/2, HIGH=N/2)
      REAL SEED
      PARAMETER (PLEN=6, PNUM=4096, SEQLEN=50500, SEED=0.45)
      CHARACTER MAT_OUT*100, SEQ*50500, PROB*6
      LOGICAL MAT_TAB(MAXNUM, PNUM)

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
c FRAG = Character string for each of the fragments
c Mat_out = a variable used to output the table
c seq = the actual sequence
c Mat_tab = the table that we are trying to generate
c TDUM, T1, T2, SECOND = variables and function used for timing.
c Low, High = variables for the recursive defintion of the starting point
c   of each of the fragments.  Each fragment starts between the low and
c   high position in the prior fragment randomly.  This allows for random
c   overlap.
c PROBE = the current probe

      T1 = SECOND(TDUM)

      CALL SEQ_GEN(SEQLEN, SEED, SEQ)
c This routine generates the actual sequence.  It is a character string
c that is filled with the letters A,T,C,G randomly

      CALL FRAG_GEN(M, MAXNUM, N, LOW, HIGH, FRAG, SEED, SEQLEN)
c This routine generates the beginning location of the fragments between
c the given boundaries Low and High.  Since each fragment starts in a
c position that is dependant on the previous fragment, it is defined
c recursively.  The actual fragment is actually copied out again.  This 
c is all done for comparison to version 3.

      CALL PROBMAT (PLEN, PNUM, N, M, MAXNUM, 
     1              MAT_TAB, FRAG, PROB, SEQ)
c This routine initializes probe and checks to see if it is in each of the 
c fragments, then the probe is updated to the next probe.  It checks every
c probe to see if it is in each of the fragments (physically).

      T2 = SECOND(TDUM) - T1

      WRITE(*,500) 'THE PROCESS TOOK ', T2, ' SECONDS'   
  500 FORMAT (A, F10.4, A)  
      
      OPEN (UNIT=1, FILE='frag.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='frag.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      DO 100 COUNT = 1, M
      WRITE(1,10) FRAG(COUNT)
   10 FORMAT (A)
  100 CONTINUE
      CLOSE(1)
    
      OPEN (UNIT=1, FILE='seq.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='seq.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      WRITE(1,10) SEQ
      CLOSE(1)

      OPEN (UNIT=1, FILE='prob_match4.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='prob_match4.dat', ACCESS='SEQUENTIAL',
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
  110 CONTINUE
      CLOSE(1)

      OPEN (UNIT=1, FILE='frag4.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='frag4.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      DO 600 I = 1, M
      WRITE(1,*) SEQ(FRAG(I):FRAG(I)+N-1)
  600 CONTINUE
      CLOSE (1)

      T1 = SECOND(TDUM) - T2
      WRITE(*,500) 'WRITING THE FILES TOOK ', T1,' SECONDS'

      STOP
      END
