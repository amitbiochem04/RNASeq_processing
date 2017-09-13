##submit job 
msub test.sh

cancell all job 
mjobctl -c -w user=hd_lo149 -w acct=acct1
showq
checkjob <jobid>
showq -r (check for active job)
showq -c (check for completed job)
canceljob <with job id >
checkjob <job_ID> get informa on of your job
checkjob -v -v -v <job_ID> All detailed informa on



mjobctl -c <job_ID>
mjobctl -c -w state=Idle mjobctl -c -w state=Running mjobctl -c -w state=BatchHold mjobctl -c -w user=$USER
cancel the job (new command) cancel ALL idle jobs
cancel ALL running jobs
cancel ALL hold jobs
cancel ALL your jobs!


######qstat

-q queue_name	Specifies a user-selectable queue (queue_name)
-r	Makes the job re-runnable
-a date_time	Executes the job only after a specific date and time (date_time)
-V	Exports environment variables in your current environment to the job
-I	Makes the job run interactively (usually for testing purposes)


qstat option	Description
-u user_list	Displays jobs for users listed in user_list
-a	Displays all jobs
-r	Displays running jobs
-f	Displays the full listing of jobs (returns excessive detail)
-n	Displays nodes allocated to jobs
