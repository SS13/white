/obj/item/device/assembly/voice
	name = "voice analyzer"
	desc = "A small electronic device able to record a voice sample, and send a signal when that sample is repeated."
	icon_state = "voice"
	m_amt = 500
	g_amt = 50
	origin_tech = "magnets=1"
	var/listening = 0
	var/recorded	//the activation message
	var/frequency = 0

	hear_talk(mob/living/M as mob, var/msg, var/italics, var/alt_name, var/freq = 0)
		if(secured)
			if(listening)
				recorded = msg
				listening = 0
				var/turf/T = get_turf(src)	//otherwise it won't work in hand
				T.visible_message("[src] beeps, \"Activation message is '[recorded]'.\"")
			else
				if(findtext(msg, recorded) && (!freq || !frequency || freq == src.frequency))
					pulse(0)

	activate()
		if(secured)
			if(!holder)
				listening = !listening
				var/turf/T = get_turf(src)
				T.visible_message("[src] beeps, \"[listening ? "Now" : "No longer"] recording input.\"")


	attack_self(mob/user)
		if(!user)	return 0
		activate()
		return 1


	toggle_secure()
		. = ..()
		listening = 0

var/list/radio_listeners = list()

/obj/item/device/assembly/voice/radio
	name = "radio voice analyzer"
	desc = "A small electronic device able to record a voice sample, and send a signal when that sample is repeated. This one has a built-in radio."
	icon_state = "radio"
	frequency = 1457

	interact(mob/user as mob, flag1)
		var/dat = {"
	<TT>
	Frequency:
	<A href='byond://?src=\ref[src];freq=-10'>-</A>
	<A href='byond://?src=\ref[src];freq=-2'>-</A>
	[format_frequency(src.frequency)]
	<A href='byond://?src=\ref[src];freq=2'>+</A>
	<A href='byond://?src=\ref[src];freq=10'>+</A><BR>

	Listening: <A href='byond://?src=\ref[src];listening=1'>[listening ? "Engaged" : "Disengaged"]</A><BR>
	</TT>"}
		user << browse(dat, "window=radiovoice")
		onclose(user, "radiovoice")
		return

	New()
		..()
		radio_listeners.Add(src)

	Del()
		radio_listeners.Remove(src)
		..()

	attack_self(mob/user)
		if(!user)	return 0
		interact(user)
		return 1

	Topic(href, href_list)
		..()

		if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
			usr << browse(null, "window=radiovoice")
			onclose(usr, "radiovoice")
			return

		if (href_list["freq"])
			var/new_frequency = (frequency + text2num(href_list["freq"]))
			if(new_frequency < 1200 || new_frequency > 1600)
				new_frequency = sanitize_frequency(new_frequency)
			frequency = new_frequency

		if(href_list["listening"])
			listening = !listening
			if(listening)
				radio_listeners.Add(src)
			else
				radio_listeners.Remove(src)

		if(usr)
			attack_self(usr)

		return