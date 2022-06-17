      function second(time)
      implicit real*8 (a-h,o-z)
      real time
      real second
c
c     this routine will gather the system time
c     and the user time for a process.
c     it has resolution of 1/60 of a second
c     and uses the unix c program times.
c     see the unix manual for details
c
      itime = mclock(i)
      time = float(itime)/60.
      second = time
      return
      end

