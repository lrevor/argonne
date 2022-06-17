.TH qconf l
.SH NAME
qconf \- DQS QueueCONFiguration

.SH SYNTAX
.B qconf -options
.PP

.SH DESCRIPTION
qconf provides the user interface for adding, deleting and
modifying a DQS queue.  qconf also provides a means for
showing the current queue configuration.
.PP
.SH Options
.PP

-ah   hostname         <add host>
                       adds a host to the DQS host list.
                       A host must reside in the DQS host list
                       to execute any of the DQS commands.
                       (The sole exception to this rule being the
                       execution of qconf on the qmaster node.)
                       Requires root/manager privileges.

-am   user             <add a manager>
                       adds a user to the manager list.
                       Requires root/manager privileges.

-ao   user             <add an operator>
                       adds a user to the operator list.
                       Requires root/manager privileges.

-aq  [q_template]      <add new queue>
                       qconf retrieves the default queue
                       configuration and execs vi (or $EDITOR
                       if EDITOR is set) to allow the custom-
                       ization of the queue configuration.
                       Upon exit from the editor the queue is
                       registered with the qmaster.  A minimal
                       configuration requires only that the
                       Qname and Qhostname be set.
                       Requires root/manager privileges.

-AQ   fname            <add new queue>
                       allows the queue described in fname
                       to be added.
                       Requires root/manager privileges.
       
-au   user [list_name] <add user>
                       adds a user to a DQS user list.  The
                       user list is used for queue usage
                       authentication.  Multiple user lists are
                       allowed.  A null user list indicates that
                       all users with a valid account have access
                       to the associated queue.  Requires root/
                       manager/operator privileges.

-axu  user [list_name] <add excluded_user>
                       adds a user to a DQS excluded user list.
                       The xuser list is used exclude users from
                       the use of a queue.  An entry in the xuser
                       list overrides an entry in the user list.
                       Multiple xuser lists are allowed.
                       Requires root/manager/operator privileges.

-cq   queuename        <clean queue>
                       cleans queue from jobs which haven't been
                       reaped. Primarily a development tool.
                       Requires root/manager/operator privileges.

-dh   hostname         <delete host>
                       deletes a host from the DQS
                       host list.  Requires root/manager priv-
                       ileges.

-dm   user             <delete a manager>
                       deletes a manager from the manager list.
                       Requires root/manager privileges.

-do   user             <delete an operator>
                       deletes an operator from the operator
                       list.  Requires root/manager privileges.

-dq   queuename        <delete queue>
                       removes the queue queuename.  Active
                       jobs will be allowed to run to comple-
                       tion.  Requires root/manager privileges.

-du   user [list_name] <delete user>
                       deletes a user from a user list.  Requires
                       root/manager/operator privileges.

-dxu  user [list_name] <delete xuser>
                       deletes a user from a DQS user list.
                       Requires root/manager/operator privileges.

-kqs                   <kill queues>
                       sends a SIGKILL to all dnqs_execds
                       and their associated processes.
                       no children are reaped.
                       BE CAREFULL!!!  -  this was primarily
                       intended as a development tool
                       Requires root/manager privileges.

-mq   queuename        <modify queue_configuration>
                       retrieves the current queue configuration,
                       execs an editor and registers the new
                       configuration with the qmaster.
                       Requires root/manager privileges.
    
-qmon                  <qmon stats>
                       returns a short version of current stats.

-sh                    <show hosts>
                       displays the DQS host list.

-sm                    <show managers>
                       displays the manager list.

-so                    <show operators>
                       displays the operator list.

-su   [list_name]      <show users>
                       displays a DQS user list.

-sul                   <show user lists>
                       displays all DQS user lists.

-sxu  [list_name]      <show xusers>
                       displays an xuser list.

-sxul                  <show xuser lists>
                       displays xuser lists.

.PP
.SH Restrictions
.PP
Modifications to a queue configuration do not affect an active queue.
The modifications take affect on next invocation of the queue(ie the
next job).  Subsequent versions will have an option for immediate
enforcement of the new configuration.
.PP
.SH "SEE ALSO"
qmod(l), qdel(l), qstat(l), qmon(l), qidle(l), qsub(l), qusage(l)




