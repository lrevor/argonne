c This program generates the data table for the genome project and
c calculates the number of extensions from that table.
C  The sequence and table are in bits.
C     THIS IS THE MAIN DRIVER PROGRAM
      include 'int_par.inc'
c
      INTEGER MAT_TAB(PCOUNT, MAXNUM)

      INTEGER FRAG(MAXNUM), PLIST(0:PNUM), NEXT_POS(0:PNUM)
      INTEGER COUNT, COUNT2, M
      REAL TDUM, T1, T2, SECOND

c Mat_tab = the table that we are trying to generate
c FRAG = list of the beginning position in the sequence for each probe
c PLIST = Used to for setting the bits in the table.
c NEXT_POS = Vector of extension probes for the current probe.  Using this
c vector allows for them to only be calculated once.
c Count, Count2 = loop variables
c TDUM, T1, T2, SECOND = variables and function used for timing.

      T1 = SECOND(TDUM)

      DO 900 COUNT=1, MAXNUM
       DO 900 COUNT2=1, PCOUNT
       MAT_TAB(COUNT2,COUNT) = 0
 900  CONTINUE

      CALL SEQ_GEN(SCOUNT, SEQ, SEED, WRDLEN)
c This routine generates the actual sequence.  It is in Bits.  It uses all
c of the bits in a word except for the left-most 2 bits.  It does not use
c these 2 bits, because the left-most is the sign bit,and it is easiest to
c only work with positive integers.

      CALL FRAG_GEN(M, MAXNUM, N, LOW, HIGH, FRAG, SEQLEN)
c This routine generates the beginning location of the fragments between
c the given boundaries Low and High.  Since each fragment starts in a
c position that is dependant on the previous fragment, it is defined
c recursively.  The actual string is no longer copied out of the
c sequence.  FRAG now only stores an integer pointing to the first
c character in the sequence that is contained by the fragment.

      CALL MATGEN (PLEN, PNUM, PCOUNT, N, M, MAXNUM, WRDLEN, SCOUNT,
     1             PLIST, FRAG, MAT_TAB, SEQ)
c This routine scans each fragment, pulling out each probe length section
c and using that to determine what probe that is and marking the
appropriate
c spot in the table.  Since this only marks the true results, the table
c must be initialized before hand.  Since the actual fragments are no
longer
c stored separately, it actual scans the sequence, but it scans the parts
of
c the sequence that are logically the fragments.

      T2 = SECOND(TDUM) - T1

      CALL STAT(PLEN, PNUM, PCOUNT, MAXNUM, M, WRDLEN, MAT_TAB, 
     1          PLIST, NEXT_POS)
c This routine calculates the number of extensions for each frag.

      T1 = SECOND(TDUM) - T2 - T1

      WRITE(*,500) 'THE GENERATION TOOK ', T2, ' SECONDS'   
      WRITE(*,500) 'THE CONSTRUCTION TOOK ', T1,' SECONDS'
  500 FORMAT (A, F10.4, A)  
      
      STOP
      END
