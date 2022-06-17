.\" SCCSID: @(#)ln.1	4.1	12/9/88
.TH qacct l
.SH NAME
qacct \- accounting for dqs
.SH SYNTAX
.B "qacct"
[options]
.SH DESCRIPTION
qacct reports the dqs usage associated with each architecture, group,
queue, or user.  A request for the break down of information per
architecture, group, queue, or users can also be made by using any
combination of the available options.  All units of time are reported
in seconds.
.PP
.SH Options
.PP

-u [user]    	all users [or a particular user]

-A [arc]    	all architectures [or a particular architecture]

-G [group]	all groups [or a particular group]

-q [queue]	all queues [or a particular queue]

-j [jobid]      list complete entry for jobid

-l              complete listing of all finished jobs
.SH "SEE ALSO"
qsub(l), qmod(l), qdel(1), qmon(l), qusage(l)
