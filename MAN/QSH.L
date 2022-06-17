.TH dsh l
.SH NAME
qsh \- Interactive Queue SHell
.SH SYNTAX
.B qsh queue [-options] 
.PP
.SH DESCRIPTION
qsh allows interactive access to the DQS queuing system. 
qsh supports single and multiple node jobs.
DQS flags may be entered as arguments to qsh.
.PP
By default all DQS requests are hard until the -S option
is encountered.  The HARD/SOFT option remains in effect
until its counterpart is encountered again.
.PP
.SH Options
.PP
-d   display     display to which xterm is thrown.(ex ds17:0)
                 By default it will be set to the machine executing
                 qsh.

-cwd             execs the job from the current working direc-
                 tory.

-pvm             starts up the pvmd(s) on granted resources.
                 requires user to sleep until they are
                 given time to start.(see example below.)

-q   queuename   requests a specific queue

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
                 argument to qsh is the "Master" queue.

-S               subsequent resource requests are considered as
                 soft until a the -H option is encountered.

.PP
.SH Example

The following are serval examples:

.PP
=====================================================
.PP
qsh ibm
.PP
requests specific queue ibm
.PP
.PP
qsh -G RIOS 1
.PP
requests an available RIOS group machine
.PP
.PP
qsh -cwd -M ibm1 -S -G RIOS 4 -pvm
.PP
ibm1 is master from which xterm is thrown
.PP
also requests 4 more RIOS group machines and
.PP
fires the pvmd
.PP
=====================================================

.PP
.SH Restrictions
.PP


.SH "SEE ALSO"
qconf(l), qmod(l), qdel(l), qstat(l), qmon(l), qidle(l), qusage(l)
















