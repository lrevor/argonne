c This is the second version of the routine to generate the table of true
c false results for the genome project.  The table represents the result from
c checking to see if a given probe is contained in a given frag.  If this is
c true then the appropriate position in the table is marked.

C     THIS PROCEDURE GENERATES THE TABLE OF ENDPOINTS

c This routine generates a table that represents the boundaries that the
c beginning of the fragment will fall between.  The given fragment will start
c somewhere randomly between ENDPT(1,count) and ENDPT(2,count).
      SUBROUTINE MKENDPT (M, ENDPT)

      INTEGER M, ENDPT(2,M), COUNT

      DO 100 COUNT = 1, M
      ENDPT(1,COUNT) = COUNT*500-499
      ENDPT(2,COUNT) = COUNT*500-499
  100 CONTINUE

      RETURN
      END


c This is the driver program.  It's purpose is to control the flow and to
c define the data.
      INTEGER M, N
      PARAMETER (M=100, N=1000)
      INTEGER ENDPT(2,M), COUNT, COUNT2, PNUM, PLEN, SEQLEN
      REAL SEED
      PARAMETER (PLEN=6, PNUM=4096, SEQLEN=50500, SEED=0.45)
      CHARACTER*1000 FRAG(M), MAT_OUT*100, SEQ*50500
      LOGICAL MAT_TAB(M, PNUM)
c     DATA ((MAT_TAB(I,J),I=1,M),J=1,PNUM) /409600*.FALSE./

      REAL TDUM, T1, T2, SECOND

c M=Number of Fragments
c N=Length of the Fragments
c ENDPT = see above
c Count, Count2 = loop variables
c Pnum = Number of probes (4**plen)
c Plen = length of the probes
c Seqlen = length of the sequence
c seed = seed for random number generator
c FRAG = The actual character strings for the fragments.
c Mat_out = a variable used to output the table
c seq = the actual sequence
c Mat_tab = the table that we are trying to generate
c TDUM, T1, T2, SECOND = variables and function used for timing.

      T1 = SECOND(TDUM)

      DO 900 COUNT=1, MAXNUM
       DO 900 COUNT2=1, PNUM
       MAT_TAB(COUNT,COUNT2) = .FALSE.
 900  CONTINUE

      CALL SEQ_GEN(SEQLEN, SEED, SEQ)
c This routine generates the actual sequence.  It is a character string
c that is filled with the letters A,T,C,G randomly

      CALL MKENDPT(M, ENDPT)
c This routine is described above

      CALL FRAG_GEN(M, N, ENDPT, FRAG, SEQ)
c This routine generates the beginning location of the fragments between
c the given boundaries from ENDPT and then copies the fragment length string
c starting at that point out of the sequence into FRAG.

      CALL MATGEN (PLEN, PNUM, N, M, MAT_TAB, FRAG)
c This routine is the difference between this version and the previous 
c version.  It scans each fragment, pulling out each probe length section
c and using that to determine what probe that is and marking the appropriate
c spot in the table.  Since this only marks the true results, the table
c must be initialized before hand.

      T2 = SECOND(TDUM) - T1

      WRITE(*,500) 'THE PROCESS TOOK ', T2, ' SECONDS'   
  500 FORMAT (A, F10.4, A)  
      
    
      OPEN (UNIT=1, FILE='seq2.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='seq2.dat', ACCESS='SEQUENTIAL',
     1      FORM='FORMATTED', STATUS='NEW')
      WRITE(1,10) SEQ
      CLOSE(1)

      OPEN (UNIT=1, FILE='prob_match2.dat')
      CLOSE (1, STATUS='DELETE')
      OPEN (UNIT=1, FILE='prob_match2.dat', ACCESS='SEQUENTIAL',
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

      T1 = SECOND(TDUM) - T2
      WRITE(*,500) 'WRITING THE FILES TOOK ', T1,' SECONDS'

      STOP
      END
