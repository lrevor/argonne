.\" SCCSID: @(#)ln.1	4.1	12/9/88
.TH qusage l
.SH NAME
qusage \- show DQS queue(s) usage
.SH SYNTAX
.B "qsuage"
[options]
.SH DESCRIPTION
qusage uses an X window interface to graphically display the utilization 
of the DQS queues over a given period of time.  qusage uses two different
formats.  The default format displays a graph based on the DQS jobs that 
have already finished.  Jobs that were lost due to a machine crash or jobs
that are still running will not be depicted in this graph.  The second
format requires the -l option.  The graph that results from this format
depicts the DQS usage over periodic polling of the DQS states.  It 
therefore also shows the queues that were running, suspended, or idle.
The usage percentage of this graph is based upon only the queues that
are either running or idle.

.PP
.SH Options
.PP

Default options:

-d  display		name of display

-days n			show the usage for the past n days since -start

-start n   		begin n days ago (default is 7)

-A architecture	specify a given architecture

-G group   		specify a given group

-q queuename		specify a given queue

-u username		specify a given user

-cpu     			report cpu utilization

With the -l option:

-d  display		name of display

-days n			show the usage for the past n days since -start

-start n   		begin n days ago (default is 7)

-a architecture	specify a given architecture

-g group   		specify a given group

.SH "SEE ALSO"
qsub(l), qmod(l), qdel(1)
