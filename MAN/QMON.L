.\" SCCSID: @(#)ln.1	4.1	12/9/88
.TH qmon l
.SH NAME
qmon \- X-Window user interface for dqs
.SH SYNTAX
.B "qmon"
[options]
.SH DESCRIPTION
qmon allows users to manipulate the dqs queues from an X-Window 
environment.  The qmon environment consists of four main components:
the main menu, the submenus, the icon window, and the output window.
The main menu allows a user to select one of the dqs utility
programs.  The submenus allow a user to enter the parameters for a
selected main menu option and then execute it.  The icon window 
displays which queues exist, and by clicking on any given queue
a user can determine the status of the queue.  All stdout/stderr 
messages from commands executed within qmon are redirected to the
output window.
.SH EDITING PARAMETERS
The only editing features currently present in qmon are those similar
to emacs.
.PP
.SH Options
.PP
-d  display	name of display

-fn font	name of font

-rv		reverse video

-l		number of lines used in output window
.SH RESTRICTIONS
.PP
Some of the qconf parameters are restricted to managers and operators
only.
.PP
Only pasting is allowed in the windows used for editing parameters.
.PP
If the line to be entered in an editing window is longer than the
width of the window, then the text just runs off the end of the window.
.PP
One size font is used for the entire application.
.PP
Only one line can be highlighted in the output window.
.PP
When a menu is closed and then re-opened, the parameters that were
previously entered are removed.
.PP
Unless you use an absolute path when submitting a job, the current
working directory (cwd main menu option) must be set to the directory
which contains the file to be submitted.
.SH "SEE ALSO"
qsub(l), qmod(l), qdel(1), qusage(l)
