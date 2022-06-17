.TH qstat l
.SH NAME
qstat \- show dqs queue(s) status
.SH SYNTAX
.B qstat [-options]
.PP
.SH Options
.PP
-s               short listing
.PP
-A    arc        show only machines in this architecture
.PP
-G    group      show only machines in this group
.PP 
-q    queue      show only this queue
.PP
-r               raw, sorted by load average
.PP
-u    username   show only this users jobs
.PP

.SH DESCRIPTION
qstat shows the current status of all available
dqs queues and the jobs associted with the queues.
.SH "SEE ALSO"
qconf(l), qmod(l), qdel(l), qmon(l), qidle(l), qsub(l), qusage(l)

