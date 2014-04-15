/datum/admins/proc/job_lock()
	if (!usr.client.holder)
		return
	var/dat = "<html><head><title>Job Lock</title></head>"
	dat += "<body>"
	dat += "<center>"
	dat += "<B>Job Lock Panel</B><BR>"
	dat += "<BR>"
	dat +="<A HREF='?src=\ref[src];job_lock=1;refresh=1'>Refresh</A><BR>"
	dat +="<BR>"
	for(var/datum/job/J in job_master.occupations)
		if(!J)	continue
		/*
		var/t = "<A HREF='?src=\ref[src];job_lock=1;select=\ref[J]'>[J.title]</A>"
		if (!J.locked)
			dat += "[t]<BR>"
		else
			dat += "\red [t]<BR>"
		*/
		if (!J.locked)
			dat += "<A HREF='?src=\ref[src];job_lock=1;select=\ref[J]'>[J.title]</A><BR>"
		else
			dat += "<A HREF='?src=\ref[src];job_lock=1;select=\ref[J]'><font color=\"red\">[J.title]</font></A><BR>"
	dat +="<BR>"
	dat +="<BR>"
	dat +="<A HREF='?src=\ref[src];job_lock=1;lock=1'>Lock all jobs</A><BR>"
	dat +="<A HREF='?src=\ref[src];job_lock=1;unlock=1'>Unlock all jobs</A><BR>"
	dat += "</center>"
	usr << browse(dat, "window=job_lock;size=250x800")