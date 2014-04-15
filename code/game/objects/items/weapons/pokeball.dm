/obj/item/weapon/poke_ball
	name = "Poke 'Ball"
	icon = 'icons/obj/pokeball.dmi'
	icon_state = "pokeball"
	slot_flags = SLOT_BELT
	var/mob/living/simple_animal/cat/Runtime/cat2/being = null
	var/mob/living/carbon/human/host = null
	var/status = 0
	w_class = 1.0

/obj/item/weapon/poke_ball/verb/Set_host()
	set name = "Set Owner"
	if(!host)
		host = usr

/obj/item/weapon/poke_ball/New()
	being = new /mob/living/simple_animal/cat/Runtime/cat2(src)
	status = 1

/obj/item/weapon/poke_ball/throw_impact(atom/hit_atom)
	if(host)
		if(!being.host)
			being.host = host

		if(!status)
			return

		var/turf/t = get_turf(hit_atom)
		being.loc = t
		status = 0
		spawn(5)
			host.put_in_hands(src)

/obj/item/weapon/poke_ball/attack_self()
	if(!status&&being in oview())
		being.loc = src
		status = 1
