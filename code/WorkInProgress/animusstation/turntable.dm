/sound/turntable/test
	file = 'TestLoop1.ogg'
	falloff = 2
	repeat = 1

/mob/var/music = 0

var/list/turntable_soundtracks = list()

proc/add_turntable_soundtracks()
	turntable_soundtracks = list()
	for(var/i in typesof(/datum/turntable_soundtrack))
		var/datum/turntable_soundtrack/D = new i()
		if(D.path)
			turntable_soundtracks.Add(D)

/datum/turntable_soundtrack
	var/f_name
	var/name
	var/path

/obj/machinery/party/turntable
	name = "Turntable"
	desc = "A jukebox is a partially automated music-playing device, usually a coin-operated machine, that will play a patron's selection from self-contained media."
	icon = 'lasers2.dmi'
	icon_state = "Jukebox7"
	var/playing = 0
	anchored = 1
	density = 1

/obj/machinery/party/mixer
	name = "mixer"
	desc = "A mixing board for mixing music"
	icon = 'lasers2.dmi'
	icon_state = "mixer"
	density = 0
	anchored = 1


/obj/machinery/party/turntable/New()
	..()
	sleep(2)
	new /sound/turntable/test(src)
	if(!turntable_soundtracks.len)
		add_turntable_soundtracks()
	return

/obj/machinery/party/turntable/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/party/turntable/attack_hand(mob/living/user as mob)
	if (..())
		return

	usr.set_machine(src)
	src.add_fingerprint(usr)

	var/t = "<body background='http://i.imgur.com/ITjP1mW.jpg'><br><br><br><div align='center'><table border='0'><B><font color='maroon' size='6'>J</font><font size='5' color='purple'>uke Box</font> <font size='5' color='green'>Interface</font></B><br><br><br><br>"
//	t += "<A href='?src=\ref[src];on=1'>On</A><br>"
	t += "<tr><td height='50' weight='50'></td><td height='50' weight='50'><A href='?src=\ref[src];off=1'><font color='maroon'>T</font><font color='geen'>urn</font> <font color='red'>Off</font></A></td><td height='50' weight='50'></td></tr>"
	t+= "<tr>"

	var/i = 0
	var/lastcolor = "green"

	for(var/datum/turntable_soundtrack/D in turntable_soundtracks)
		if(i == 3)
			i = 0
			t += "</tr><tr>"

		if(lastcolor == "green")
			lastcolor = "purple"
		else
			lastcolor = "green"
		t += "<td height='50' weight='50'><A href='?src=\ref[src];on=\ref[D]'><font color='maroon'>[D.f_name]</font><font color='[lastcolor]'>[D.name]</font></A></td>"
		i++

	t += "</table></div></body>"
	user << browse(t, "window=turntable;size=450x700")
	onclose(user, "turntable")
	return

/obj/machinery/party/turntable/Topic(href, href_list)
	if(..())
		return

	if(href_list["on"])
		if(src.playing == 0)
			//world << "Should be working..."
			var/datum/turntable_soundtrack/D = locate(href_list["on"])
			if(!istype(D))
				return

			var/sound/S = sound(D.path)

			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1
			var/area/A = src.loc.loc:master

			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if((M.loc.loc in A.related) && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(!(M.loc.loc in A.related) && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if(href_list["off"])
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc:master
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()


/obj/machinery/party/lasermachine
	name = "laser machine"
	desc = "A laser machine that shoots lasers."
	icon = 'lasers2.dmi'
	icon_state = "lasermachine"
	anchored = 1
	var/mirrored = 0

/obj/effects/laser
	name = "laser"
	desc = "A laser..."
	icon = 'lasers2.dmi'
	icon_state = "laserred1"
	anchored = 1
	layer = 4

/obj/machinery/party/lasermachine/proc/turnon()
	var/wall = 0
	var/cycle = 1
	var/area/A = get_area(src)
	var/X = 1
	var/Y = 0
	if(mirrored == 0)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred1"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 2)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred2"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 3)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred3"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
	if(mirrored == 1)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred1m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 2)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred2m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 3)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred3m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++



/obj/machinery/party/lasermachine/proc/turnoff()
	var/area/A = src.loc.loc
	for(var/area/RA in A.related)
		for(var/obj/effects/laser/F in RA)
			del(F)

