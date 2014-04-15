/obj/item/device/assembly/health
	name = "health sensor"
	desc = "Used for scanning and monitoring health."
	icon_state = "health"
	m_amt = 800
	g_amt = 200
	origin_tech = "magnets=1;biotech=1"

	var/scanning = 0

	var/health_scan

	proc
		toggle_scan()
		sense()



	activate()
		if(!..())	return 0//Cooldown check
		scanning = !scanning
		return 0

	toggle_secure()
		secured = !secured
		if(secured)
			processing_objects.Add(src)
		else
			scanning = 0
			processing_objects.Remove(src)
		update_icon()
		return secured


	sense()
		if(!secured|| !scanning || cooldown > 0)	return 0
		pulse(0)
		visible_message("\icon[src] *beep* *beep*", "*beep* *beep*")
		cooldown = 2
		spawn(10)
			process_cooldown()
		return


	process()
		if(!scanning || !secured)
			return

		var/mob/living/M = find_mob_loc(src)

		if(M)
			health_scan = M.health
			if(health_scan < 0)
				sense()
				scanning = 0
			return
		return

	toggle_scan()
		if(!secured)	return 0
		scanning = !scanning
		if(scanning)
			processing_objects.Add(src)
		else
			processing_objects.Remove(src)
		return

	interact(mob/user as mob)//TODO: Change this to the wires thingy
		if(!secured)
			user.show_message("\red The [name] is unsecured!")
			return 0
		var/dat = text("<TT><B>Health Sensor</B> <A href='?src=\ref[src];scanning=1'>[scanning?"On":"Off"]</A>")
		if(scanning && health_scan)
			dat += "<BR>Health: [health_scan]"
		user << browse(dat, "window=hscan")
		onclose(user, "hscan")
		return


	Topic(href, href_list)
		..()
		if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
			usr << browse(null, "window=hscan")
			onclose(usr, "hscan")
			return

		if(href_list["scanning"])
			toggle_scan()

		if(href_list["close"])
			usr << browse(null, "window=hscan")
			return

		if(usr)
			attack_self(usr)

		return

	open
		secured = 0

proc/find_mob_loc(atom/A)
	if(ismob(A))return A
	if(A.loc)	return .(A.loc)

	return 0