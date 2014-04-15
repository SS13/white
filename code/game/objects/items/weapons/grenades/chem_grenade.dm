/obj/item/weapon/grenade/chem_grenade
	name = "Grenade Casing"
	icon_state = "chemg"
	item_state = "flashbang"
	desc = "A hand made chemical grenade."
	w_class = 2.0
	force = 2.0
	var/stage = 0
	var/state = 0
	var/path = 0
	var/obj/item/device/assembly_holder/detonator = null
	var/list/beakers = new/list()
	var/list/allowed_containers = list(/obj/item/weapon/reagent_containers/glass/beaker, /obj/item/weapon/reagent_containers/glass/bottle)
	var/affected_area = 3

	New()
		var/datum/reagents/R = new/datum/reagents(1000)
		reagents = R
		R.my_atom = src

	attack_self(mob/user as mob)
		if(!stage || stage==1)
			if(detonator)
//				detonator.loc=src.loc
				detonator.detached()
				usr.put_in_hands(detonator)
				detonator=null
				stage=0
				icon_state = initial(icon_state)
			else if(beakers.len)
				for(var/obj/B in beakers)
					if(istype(B))
						beakers -= B
						user.put_in_hands(B)
			name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
		if(stage > 1 && !active && clown_check(user))
			user << "<span class='warning'>You prime \the [name]!</span>"

			msg_admin_attack("[user.name] ([user.ckey]) primed \a [src]. (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
			activate()
			add_fingerprint(user)
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W,/obj/item/device/assembly_holder) && (!stage || stage==1) && path != 2)
			var/obj/item/device/assembly_holder/det = W
			if(istype(det.a_left,det.a_right.type) || (!isigniter(det.a_left) && !isigniter(det.a_right)))
				user << "\red Assembly must contain one igniter."
				return
			if(!det.secured)
				user << "\red Assembly must be secured with screwdriver."
				return
			path = 1
			user << "\blue You add [W] to the metal casing."
			playsound(src.loc, 'sound/items/Screwdriver2.ogg', 25, -3)
			user.remove_from_mob(det)
			det.loc = src
			detonator = det
			icon_state = initial(icon_state) +"_ass"
			name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
			stage = 1
		else if(istype(W,/obj/item/weapon/screwdriver) && path != 2)
			if(stage == 1)
				path = 1
				if(beakers.len)
					user << "\blue You lock the assembly."
					name = "grenade"
				else
//					user << "\red You need to add at least one beaker before locking the assembly."
					user << "\blue You lock the empty assembly."
					name = "fake grenade"
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, -3)
				icon_state = initial(icon_state) +"_locked"
				stage = 2
			else if(stage == 2)
				if(active && prob(95))
					user << "\red You trigger the assembly!"
					prime()
					return
				else
					user << "\blue You unlock the assembly."
					playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, -3)
					name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
					icon_state = initial(icon_state) + (detonator?"_ass":"")
					stage = 1
					active = 0
		else if(is_type_in_list(W, allowed_containers) && (!stage || stage==1) && path != 2)
			path = 1
			if(beakers.len == 2)
				user << "\red The grenade can not hold more containers."
				return
			else
				if(W.reagents.total_volume)
					user << "\blue You add \the [W] to the assembly."
					user.drop_item()
					W.loc = src
					beakers += W
					stage = 1
					name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
				else
					user << "\red \the [W] is empty."

	examine()
		set src in usr
		usr << desc
		if(detonator)
			usr << "With attached [detonator.name]"

	activate(mob/user as mob)
		if(active) return

		if(detonator)
			if(!isigniter(detonator.a_left))
				detonator.a_left.activate()
				active = 1
			if(!isigniter(detonator.a_right))
				detonator.a_right.activate()
				active = 1
		if(active)
			icon_state = initial(icon_state) + "_active"

			if(user)
				msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

		return

	proc/primed(var/primed = 1)
		if(active)
			icon_state = initial(icon_state) + (primed?"_primed":"_active")

	prime()
		if(!stage || stage<2) return

		//if(prob(reliability))
		var/has_reagents = 0
		for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
			if(G.reagents.total_volume) has_reagents = 1

		active = 0
		if(!has_reagents)
			icon_state = initial(icon_state) +"_locked"
			playsound(src.loc, 'sound/items/Screwdriver2.ogg', 50, 1)
			return

		playsound(src.loc, 'sound/effects/bamf.ogg', 50, 1)

		for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
			G.reagents.trans_to(src, G.reagents.total_volume)

		if(src.reagents.total_volume) //The possible reactions didnt use up all reagents.
			var/datum/effect/effect/system/steam_spread/steam = new /datum/effect/effect/system/steam_spread()
			steam.set_up(10, 0, get_turf(src))
			steam.attach(src)
			steam.start()

			for(var/atom/A in view(affected_area, src.loc))
				if( A == src ) continue
				src.reagents.reaction(A, 1, 10)


		invisibility = INVISIBILITY_MAXIMUM //Why am i doing this?
		spawn(50)		   //To make sure all reagents can work
			del(src)	   //correctly before deleting the grenade.
		/*else
			icon_state = initial(icon_state) + "_locked"
			crit_fail = 1
			for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
				G.loc = get_turf(src.loc)*/

		if(detonator)
			usr << "With attached [detonator.name]"


/obj/item/weapon/grenade/chem_grenade/HasProximity(atom/movable/AM as mob|obj)
	if(detonator)
		detonator.HasProximity(AM)

/obj/item/weapon/grenade/chem_grenade/HasEntered(atom/movable/AM as mob|obj) //for mousetraps
	if(detonator)
		detonator.HasEntered(AM)

/obj/item/weapon/grenade/chem_grenade/on_found(mob/finder as mob) //for mousetraps
	if(detonator)
		return detonator.on_found(finder)

/obj/item/weapon/grenade/chem_grenade/hear_talk(mob/living/M, msg)
	if(detonator)
		detonator.hear_talk(M, msg)


/obj/item/weapon/grenade/chem_grenade/large
	name = "Large Chem Grenade"
	desc = "An oversized grenade that affects a larger area."
	icon_state = "large_grenade"
	allowed_containers = list(/obj/item/weapon/reagent_containers/glass)
	origin_tech = "combat=3;materials=3"
	affected_area = 4

/obj/item/weapon/grenade/chem_grenade/metalfoam
	name = "Metal-Foam Grenade"
	desc = "Used for emergency sealing of air breaches."
	path = 1
	stage = 2

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("aluminum", 30)
		B2.reagents.add_reagent("foaming_agent", 10)
		B2.reagents.add_reagent("pacid", 10)

		detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

		beakers += B1
		beakers += B2
		icon_state = initial(icon_state) +"_locked"

/obj/item/weapon/grenade/chem_grenade/incendiary
	name = "Incendiary Grenade"
	desc = "Used for clearing rooms of living things."
	path = 1
	stage = 2

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("aluminum", 15)
		B1.reagents.add_reagent("fuel",20)
		B2.reagents.add_reagent("plasma", 15)
		B2.reagents.add_reagent("sacid", 15)
		B1.reagents.add_reagent("fuel",20)

		detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

		beakers += B1
		beakers += B2
		icon_state = initial(icon_state) +"_locked"

/obj/item/weapon/grenade/chem_grenade/antiweed
	name = "weedkiller grenade"
	desc = "Used for purging large areas of invasive plant species. Contents under pressure. Do not directly inhale contents."
	path = 1
	stage = 2

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("plantbgone", 25)
		B1.reagents.add_reagent("potassium", 25)
		B2.reagents.add_reagent("phosphorus", 25)
		B2.reagents.add_reagent("sugar", 25)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

/obj/item/weapon/grenade/chem_grenade/cleaner
	name = "Cleaner Grenade"
	desc = "BLAM!-brand foaming space cleaner. In a special applicator for rapid cleaning of wide areas."
	stage = 2
	path = 1

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("fluorosurfactant", 40)
		B2.reagents.add_reagent("water", 40)
		B2.reagents.add_reagent("cleaner", 10)

		detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

		beakers += B1
		beakers += B2
		icon_state = initial(icon_state) +"_locked"

//improvised explosives//

//iedcasing assembly crafting, ported like a shit//
/obj/item/weapon/reagent_containers/food/drinks/cola/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/G = new /obj/item/device/assembly/igniter
		var/obj/item/weapon/grenade/iedcasing/W = new /obj/item/weapon/grenade/iedcasing
		user.before_take_item(G)
		user.before_take_item(src)
		user.put_in_hands(W)
		user << "<span  class='notice'>You stuff the [I] in the [src], emptying the contents beforehand.</span>"
		W.underlays += image(src.icon, icon_state = src.icon_state)
		del(I)
		del(src)

/obj/item/weapon/reagent_containers/food/drinks/starkist/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/G = new /obj/item/device/assembly/igniter
		var/obj/item/weapon/grenade/iedcasing/W = new /obj/item/weapon/grenade/iedcasing
		user.before_take_item(G)
		user.before_take_item(src)
		user.put_in_hands(W)
		user << "<span  class='notice'>You stuff the [I] in the [src], emptying the contents beforehand.</span>"
		W.underlays += image(src.icon, icon_state = src.icon_state)
		del(I)
		del(src)

/obj/item/weapon/reagent_containers/food/drinks/space_up/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/G = new /obj/item/device/assembly/igniter
		var/obj/item/weapon/grenade/iedcasing/W = new /obj/item/weapon/grenade/iedcasing
		user.before_take_item(G)
		user.before_take_item(src)
		user.put_in_hands(W)
		user << "<span  class='notice'>You stuff the [I] in the [src], emptying the contents beforehand.</span>"
		W.underlays += image(src.icon, icon_state = src.icon_state)
		del(I)
		del(src)

/obj/item/weapon/reagent_containers/food/drinks/dr_gibb/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/G = new /obj/item/device/assembly/igniter
		var/obj/item/weapon/grenade/iedcasing/W = new /obj/item/weapon/grenade/iedcasing
		user.before_take_item(G)
		user.before_take_item(src)
		user.put_in_hands(W)
		user << "<span  class='notice'>You stuff the [I] in the [src], emptying the contents beforehand.</span>"
		W.underlays += image(src.icon, icon_state = src.icon_state)
		del(I)
		del(src)

/obj/item/weapon/reagent_containers/food/drinks/space_mountain_wind/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/G = new /obj/item/device/assembly/igniter
		var/obj/item/weapon/grenade/iedcasing/W = new /obj/item/weapon/grenade/iedcasing
		user.before_take_item(G)
		user.before_take_item(src)
		user.put_in_hands(W)
		user << "<span  class='notice'>You stuff the [I] in the [src], emptying the contents beforehand.</span>"
		W.underlays += image(src.icon, icon_state = src.icon_state)
		del(I)
		del(src)

/obj/item/weapon/grenade/iedcasing
	name = "improvised explosive assembly"
	desc = "An igniter stuffed into an aluminium shell."
	w_class = 2.0
	icon = 'icons/obj/grenade.dmi'
	icon_state = "improvised_grenade"
	item_state = "flashbang"
	throw_speed = 3
	throw_range = 7
	flags = CONDUCT
	slot_flags = SLOT_BELT
	var/assembled = 0
	active = 1
	det_time = 50



/obj/item/weapon/grenade/iedcasing/afterattack(atom/target, mob/user , flag) //Filling up the can
	if(assembled == 0)
		if(istype(target, /obj/structure/reagent_dispensers/fueltank) && in_range(src, target))
			if(target.reagents.total_volume < 50)
				user << "<span  class='notice'>There's not enough fuel left to work with.</span>"
				return
			var/obj/structure/reagent_dispensers/fueltank/F = target
			F.reagents.remove_reagent("fuel", 50, 1)//Deleting 50 fuel from the welding fuel tank,
			assembled = 1
			user << "<span  class='notice'>You've filled the makeshift explosive with welding fuel.</span>"
			playsound(src.loc, 'sound/effects/refill.ogg', 50, 1, -6)
			desc = "An improvised explosive assembly. Filled to the brim with 'Explosive flavor'"
			overlays += image('icons/obj/grenade.dmi', icon_state = "improvised_grenade_filled")
			return


/obj/item/weapon/grenade/iedcasing/attackby(var/obj/item/I, mob/user as mob) //Wiring the can for ignition
	if(istype(I, /obj/item/weapon/cable_coil))
		if(assembled == 1)
			var/obj/item/weapon/cable_coil/C = I
			C.use(1)
			assembled = 2
			user << "<span  class='notice'>You wire the igniter to detonate the fuel.</span>"
			desc = "A weak, improvised explosive."
			overlays += image('icons/obj/grenade.dmi', icon_state = "improvised_grenade_wired")
			name = "improvised explosive"
			active = 0
			det_time = rand(30,80)

/obj/item/weapon/grenade/iedcasing/attack_self(mob/user as mob) //
	if(!active)
		if(clown_check(user))
			user << "<span class='warning'>You light the [name]!</span>"
			active = 1
			overlays -= image('icons/obj/grenade.dmi', icon_state = "improvised_grenade_filled")
			icon_state = initial(icon_state) + "_active"
			assembled = 3
			add_fingerprint(user)
			var/turf/bombturf = get_turf(src)
			var/area/A = get_area(bombturf)

			message_admins("[key_name(usr)]<A HREF='?_src_=holder;adminmoreinfo=\ref[usr]'>?</A> has primed a [name] for detonation at <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[bombturf.x];Y=[bombturf.y];Z=[bombturf.z]'>[A.name] (JMP)</a>.")
			log_game("[key_name(usr)] has primed a [name] for detonation at [A.name] ([bombturf.x],[bombturf.y],[bombturf.z]).")
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()
			spawn(det_time)
				prime()

/obj/item/weapon/grenade/iedcasing/prime() //Blowing that can up
	update_icon()
	explosion(src.loc,-1,0,2)
	del(src)

/obj/item/weapon/grenade/iedcasing/examine()
	set src in usr
	..()
	if(assembled == 3)
		usr << "You can't tell when it will explode!"
