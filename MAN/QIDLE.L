.\" SCCSID: @(#)ln.1	4.1	12/9/88
.TH qidle l
.SH NAME
qidle \- monitors X-Window server
.SH SYNTAX
.B "qidle" [options] -q queuename
.SH DESCRIPTION
qidle monitors the X-Window activity and if a user is interactively
using the console, then the local queue is automatically suspended.
If the server is idle for a certain period of time then qidle enables
the queue.  The sleep button allows the user to modify the length of
time that the queue can be suspended.
.PP
.SH Options
.PP

-d  display 	name of display

-s seconds	time in which the queue is suspended (default=300)

-g geometry

-q queuename

.SH "SEE ALSO"
qsub(l), qmod(l), qdel(1)
