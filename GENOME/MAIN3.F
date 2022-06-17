c This is the third version of the routine to generate the table of true
c false results for the genome project.  The table represents the result from
c checking to see if a given probe is contained in a given frag.  If this is
c true then the appropriate position in the table is marked.

      INCLUDE 'int_par.inc'
      INCLUDE 'char_par.inc'

      INTEGER COUNT, COUNT2, M
      INTEGER FRAG(MAXNUM)
      CHARACTER MAT_OUT*100
      LOGICAL MAT_TAB(0:PNUM, MAXNUM)

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
       DO 900 COUNT2=0, PNUM
       MAT_TAB(COUNT2,COUNT) = .FALSE.
 900  CONTINUE

      CALL SEQ_GEN(SEQLEN, SEED, SEQ)
c This routine generates the actual sequence.  It is a character string
c that is filled with the letters A,T,C,G randomly

      CALL FRAG_GEN(M, MAXNUM, N, LOW, HIGH, SEED, FRAG, SEQLEN)
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

      CALL STAT(PLEN, PNUM, M, MAXNUM, MAT_TAB)
c This routine calculates the number of extensions for each frag.

      T1 = SECOND(TDUM) - T2 - T1

      WRITE(*,500) 'THE GENERATION TOOK ', T2, ' SECONDS'   
      WRITE(*,500) 'THE CONSTRUCTION TOOK ', T1,' SECONDS'

  500 FORMAT (A, F10.4, A)  
      
      STOP
      END
