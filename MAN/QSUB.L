.TH qsub l
.SH NAME
qsub \- submit a job to the DQS queuing system
.SH SYNTAX
.B qsub [queue] [-options] scriptfile
.PP
.SH DESCRIPTION
qsub submits jobs to the DQS queuing system. 
DQS supports single and multiple node jobs.
DQS flags may be entered as arguments to qsub
or as embedded flags in the shell script.  

The following commands are considered as
mutually exclusive:
.PP
-e and -eo
.br
-eo and -o
.br
-mu
.br
-nr and -r
.br
-M
.PP
In the case of mutually exclusive requests 
qsub invalidates the previous request.
The order of precedence of evaluation is as follows:
left to right
from top to bottom of the script file
from left to right of the command line.
(ie the command line can be used to override
the embedded flags.)
.PP
All other requests are additive.(ie, you can keep adding resources.)
.PP
By default all DQS requests are hard until the -S option
is encountered.  The HARD/SOFT option remains in effect
until its counterpart is encountered again.
.PP
The qmaster uses a stingy algorithm for the scheduler.
It will attempt to allocate queues on a first come first 
served basis.  If all the hard requests for a job cannot 
be met, the scheduler will proceed until a runnable job(s) 
can be found.(Jobs which cannot be run remained spooled.)
.PP
.SH Options
.PP
-e   fname       STDERR will be redirected to the file fname.  fname
                 may be either an absolute pathname or relative
                 to the cwd.

-eo  fname       STDERR and STDOUT will be redirected to the file
                 fname.  fname may be either an absolute pathname
                 or relative to the cwd of the execd job.

-cwd            execs the job from the current working direc-
                 tory.

-o   fname       STDOUT will be redirected to the file fname.  fname
                 may be either an absolute pathname or relative
                 to the cwd.

-mb              send mail notification at beginning of job.
                 A parallel job will only send mail from the
                 Master.

-me              send mail notification at the end of job.
                 A parallel job will only send mail from the
                 Master.

-ms              send mail notification at any signaling of job
                 (such as suspend/unsuspend)  A parallel job will
                 only send mail from the Master.

-mu   username   send mail to user username

-nr              no restart option

-pvm             starts up the pvmd(s) on granted resources.
                 requires user to sleep until they are
                 given time to start.(see example below.)

-q   queuename   requests a specific queue

-r               restart option (default).

-s   shell       shell to be exec'ed for interpretation of the
                 script file.

-v               verify option.  Command line and script file
                 are parsed and requests are printed to STDOUT
                 for script file debug purposes.

-G   group num   request num queues of group group.

-H               subsequent resource requests are considered as
                 hard until the -S option is encount.

-M   queue       sets the "Master" controlling queue to queue
                 queuename.  This will be the controlling "node"
                 for parallel jobs and will be the node to which
                 the script file is handed.  A Master request is
                 considered a hard request.  By default the first
                 argument to qsub is the "Master" queue.

-S               subsequent resource requests are considered as
                 soft until a the -H option is encountered.

.PP
.SH Example

The following is a short example of a DQS script file.

.PP
=====================================================
.PP
#!/bin/csh
.PP
.PP
# we want ibms320h-1 as the master
.br
#$ -M ibms320h-1.par
.PP
.PP
# we need at least 2 more IBMs
.br
#$ -H -G ibms.par 2
.PP
.PP
# and we'd like 1 more IBM if we can get it
.br
#$ -S -G ibms.par 1
.PP
.PP
# and a couple decstations just for the fun of it
.br
#$ -S -G decstation 1
.PP
.PP
# make the current directory the CWD
.br
#$ -cwd
.PP
.PP
# lets put STDOUT/STDERR in the file gaga
.br
#$ -eo gaga
.PP
.PP
# i'd like to know when she fires
.br
#$ -mu green@ds17.scri.fsu.edu
.br 
#$ -mb
.PP
.PP
# and when she finishes
.br
#$ -me
.PP
.PP
# it be time to run
.br
# lets fire the pvm daemon
.br
#$ -pvm
.br
.PP
# give the pvmds time to fire
.br
sleep 20
.PP
.PP
# STDOUT from the pvm will go in JOBNAME.PVMO
.br
# STDERR from the pvm will go in JOBNAME.PVME
.br
# both relative to the CWD
.br
# additionally the file JOBNAME.HOSTS will
.br
# be written for pvm applications
.PP
.PP
# now for the user application
.br
pvmhost 
.PP
.PP
# da da dats all folks!!!
.PP
=====================================================

.PP
.SH Restrictions
.PP

There is no controlling terminal under DQS.
Any tests or actions on a controlling terminal 
will fail.  If these operations are in
your .login or .cshrc file, they will possibly
cause your job to terminate.

You may want to insert the following code 
before commands not pertinent to batched jobs
in your .login

           if ( $?JOB_NAME) then
              echo "DQS Spooled Job"
              exit 0
              endif

Your paths/etc should be set before this code.

.SH "SEE ALSO"
qconf(l), qmod(l), qdel(l), qstat(l), qmon(l), qidle(l), qusage(l)
















