.TH qmod l
.SH NAME
qmod \- modify a DQS queue
.SH SYNTAX
.B qmod -e/s/soc/xsoc [-f] queue
.PP
.B qmod -e/s/soc/xsoc [-f] -A arc
.PP
.B qmod -e/s/soc/xsoc [-f] -G group
.PP
qmod enables users classified as an "owners" of a 
workstation to modify
the state of a dqs queue for his/her machine.
(A manager/operator or root can execute qmod for
any queue in a cluster.)
.PP
.SH Options
.PP
-s        suspends the queue and any jobs which might
          be active.
.PP
-e        enables the queue and any jobs which might be
          suspended.
.PP     
-sr       NOT IMPLEMENTED YET suspends the queue after the current job has
          completed execution.
.PP
-f        forces action regardless if execd can be contacted
          only affects queue status, not job status.
.PP
-A  arc   suspends all queues of type arc.
.PP
-G  group suspends all queues of group group.  
.PP
-soc      Suspend_On_Completion of current executing job.
          is reset by -xsoc or when dqs_execd restarts.
.PP
-xsoc     cancels -soc option.
.PP
.SH Restrictions
.PP
Suspension of an active parallel queue could lead to blocking
other nodes in the run. 
.PP
.SH "SEE ALSO"
qconf(l), qdel(l), qstat(l), qmon(l), qidle(l), qsub(l), qusage(l)

