      INTEGER N, LOW, HIGH, WRDLEN
      PARAMETER (N=1000, LOW=N/2, HIGH=N/2, WRDLEN=32)
      INTEGER MAXNUM
      PARAMETER (MAXNUM=100) 
      INTEGER PLEN, PNUM, SEQLEN, SEED
      PARAMETER (PLEN=6, PNUM=4**PLEN-1, SEQLEN=50500, SEED=200)
      INTEGER PCOUNT
      PARAMETER (PCOUNT=(PNUM+1)/WRDLEN)
c N=Length of the Fragments
c Low, High = variables for the recursive defintion of the starting point
c   of each of the fragments.  Each fragment starts between the low and
c   high position in the prior fragment randomly.  This allows for random
c   overlap.
c WRDLEN = The word length
c Maxnum = the maximum number of fragments possible
c Pnum = Number of probes (4**plen)
c Plen = length of the probes
c Seqlen = length of the sequence
c seed = seed for random number generator
c PCOUNT = The number of words required for all the probes
