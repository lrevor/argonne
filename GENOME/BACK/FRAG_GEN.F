c This routine takes the parameters High and Low and uses them to
c recursively define frag which is an array that points to the beginning of
c the fragments in the sequence.  The fragments are NOT copied out.

      SUBROUTINE FRAG_GEN (M, MAXNUM, N, LOW, HIGH, FRAG, SEED, SEQ_LEN)

      INTEGER M, MAXNUM, N, LOW, HIGH, FRAG(M), SEQ_LEN
      REAL SEED

c M = Number of fragments
c MAXNUM = Maximum number of fragments
c N = Length of the fragments
c Low = used to define the overlap region
c High = high side of the possible overlap region
c Frag = pointers to the beginning of the fragments
c seq_len = the length of the sequence
c seed = seed value for the random number generator

      FRAG(1) = 1
      M = 2
   10 SEED = RAND(SEED)
      FRAG(M) = INT(SEED*REAL(HIGH-LOW+1)) + LOW + FRAG(M-1)
      IF ((FRAG(M)+N) .GT. SEQ_LEN) THEN
        FRAG(M) = SEQ_LEN-N+1
       ELSE
        M = M+1
        GO TO 10
      END IF

      RETURN
      END
