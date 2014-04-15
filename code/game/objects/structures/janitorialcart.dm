/obj/structure/janitorialcart
	name = "janitorial cart"
	desc = "This is the alpha and omega of sanitation."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cart"
	anchored = 0
	density = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/obj/item/weapon/mop/mymop = null
	var/obj/item/weapon/reagent_containers/spray/myspray = null
	var/obj/item/device/lightreplacer/myreplacer = null
	var/signs = 0	//maximum capacity hardcoded below


/obj/structure/janitorialcart/New()
	create_reagents(100)


/obj/structure/janitorialcart/examine()
	set src in usr
	usr << "[src] \icon[src] contains [reagents.total_volume] unit\s of liquid!"
	..()
	//everything else is visible, so doesn't need to be mentioned


/obj/structure/janitorialcart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/storage/bag/trash) && !mybag)
		user.drop_item()
		mybag = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/mop))
		if(I.reagents.total_volume < I.reagents.maximum_volume)	//if it's not completely soaked we assume they want to wet it, otherwise store it
			if(reagents.total_volume < 1)
				user << "[src] is out of water!</span>"
			else
				reagents.trans_to(I, 5)	//
				user << "<span class='notice'>You wet [I] in [src].</span>"
				playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
				return
		if(!mymop)
			user.drop_item()
			mymop = I
			I.loc = src
			update_icon()
			updateUsrDialog()
			user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/reagent_containers/spray) && !myspray)
		user.drop_item()
		myspray = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/device/lightreplacer) && !myreplacer)
		user.drop_item()
		myreplacer = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/caution))
		if(signs < 4)
			user.drop_item()
			I.loc = src
			signs++
			update_icon()
			updateUsrDialog()
			user << "<span class='notice'>You put [I] into [src].</span>"
		else
			user << "<span class='notice'>[src] can't hold any more signs.</span>"

	else if(mybag)
		mybag.attackby(I, user)


/obj/structure/janitorialcart/attack_hand(mob/user)
	user.set_machine(src)
	var/dat
	if(mybag)
		dat += "<a href='?src=\ref[src];garbage=1'>[mybag.name]</a><br>"
	if(mymop)
		dat += "<a href='?src=\ref[src];mop=1'>[mymop.name]</a><br>"
	if(myspray)
		dat += "<a href='?src=\ref[src];spray=1'>[myspray.name]</a><br>"
	if(myreplacer)
		dat += "<a href='?src=\ref[src];replacer=1'>[myreplacer.name]</a><br>"
	if(signs)
		dat += "<a href='?src=\ref[src];sign=1'>[signs] sign\s</a><br>"

	user << browse(dat, "window=janicart;size=400x500")
	onclose(user, "janicart")
	return


/obj/structure/janitorialcart/Topic(href, href_list)
	if(!in_range(src, usr))
		return
	if(!isliving(usr))
		return
	var/mob/living/user = usr
	if(href_list["garbage"])
		if(mybag)
			user.put_in_hands(mybag)
			user << "<span class='notice'>You take [mybag] from [src].</span>"
			mybag = null
	if(href_list["mop"])
		if(mymop)
			user.put_in_hands(mymop)
			user << "<span class='notice'>You take [mymop] from [src].</span>"
			mymop = null
	if(href_list["spray"])
		if(myspray)
			user.put_in_hands(myspray)
			user << "<span class='notice'>You take [myspray] from [src].</span>"
			myspray = null
	if(href_list["replacer"])
		if(myreplacer)
			user.put_in_hands(myreplacer)
			user << "<span class='notice'>You take [myreplacer] from [src].</span>"
			myreplacer = null
	if(href_list["sign"])
		if(signs)
			var/obj/item/weapon/caution/Sign = locate() in src
			if(Sign)
				user.put_in_hands(Sign)
				user << "<span class='notice'>You take \a [Sign] from [src].</span>"
				signs--
			else
				warning("[src] signs ([signs]) didn't match contents")
				signs = 0

	update_icon()
	updateUsrDialog()


/obj/structure/janitorialcart/update_icon()
	overlays = null
	if(mybag)
		overlays += "cart_garbage"
	if(mymop)
		overlays += "cart_mop"
	if(myspray)
		overlays += "cart_spray"
	if(myreplacer)
		overlays += "cart_replacer"
	if(signs)
		overlays += "cart_sign[signs]"


//old style retardo-cart
/obj/structure/stool/bed/chair/janicart
	name = "janicart"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "pussywagon"
	anchored = 1
	density = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/callme = "pimpin' ride"	//how do people refer to it?


/obj/structure/stool/bed/chair/janicart/New()
	handle_rotation()
	create_reagents(100)


/obj/structure/stool/bed/chair/janicart/examine()
	set src in usr
	usr << "\icon[src] This [callme] contains [reagents.total_volume] unit\s of water!"
	if(mybag)
		usr << "\A [mybag] is hanging on the [callme]."


/obj/structure/stool/bed/chair/janicart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mop))
		if(reagents.total_volume > 1)
			reagents.trans_to(I, 2)
			user << "<span class='notice'>You wet [I] in the [callme].</span>"
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		else
			user << "<span class='notice'>This [callme] is out of water!</span>"
	else if(istype(I, /obj/item/key))
		user << "Hold [I] in one of your hands while you drive this [callme]."
	else if(istype(I, /obj/item/weapon/storage/bag/trash))
		user << "<span class='notice'>You hook the trashbag onto the [callme].</span>"
		user.drop_item()
		I.loc = src
		mybag = I


/obj/structure/stool/bed/chair/janicart/attack_hand(mob/user)
	if(mybag)
		mybag.loc = get_turf(user)
		user.put_in_hands(mybag)
		mybag = null
	else
		..()


/obj/structure/stool/bed/chair/janicart/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	if(istype(user.l_hand, /obj/item/key) || istype(user.r_hand, /obj/item/key))
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this [callme].</span>"


/obj/structure/stool/bed/chair/janicart/Move()
	..()
	if(buckled_mob)
		if(buckled_mob.buckled == src)
			buckled_mob.loc = loc


/obj/structure/stool/bed/chair/janicart/buckle_mob(mob/M, mob/user)
	if(M != user || !ismob(M) || get_dist(src, user) > 1 || user.restrained() || user.lying || user.stat || M.buckled || istype(user, /mob/living/silicon))
		return

	unbuckle()

	M.visible_message(\
		"<span class='notice'>[M] climbs onto the [callme]!</span>",\
		"<span class='notice'>You climb onto the [callme]!</span>")
	M.buckled = src
	M.loc = loc
	M.dir = dir
	M.update_canmove()
	buckled_mob = M
	update_mob()
	add_fingerprint(user)


/obj/structure/stool/bed/chair/janicart/unbuckle()
	if(buckled_mob)
		buckled_mob.pixel_x = 0
		buckled_mob.pixel_y = 0
	..()


/obj/structure/stool/bed/chair/janicart/handle_rotation()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()


/obj/structure/stool/bed/chair/janicart/proc/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir
		switch(dir)
			if(SOUTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 7
			if(WEST)
				buckled_mob.pixel_x = 13
				buckled_mob.pixel_y = 7
			if(NORTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 4
			if(EAST)
				buckled_mob.pixel_x = -13
				buckled_mob.pixel_y = 7


/obj/structure/stool/bed/chair/janicart/bullet_act(var/obj/item/projectile/Proj)
	if(buckled_mob)
		if(prob(85))
			return buckled_mob.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the [callme]!</span>")


/obj/item/key
	name = "key"
	desc = "A keyring with a small steel key, and a pink fob reading \"Pussy Wagon\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "keys"
	w_class = 1

///////////////////////////////////////////
/////////////// WHEELCHAIR ///////////////
////////////// WIP by Loly //////////////
/////////////////////////////////////////

/obj/structure/stool/bed/chair/wheelchair
	name = "wheelchair"
	icon = 'icons/obj/vehicles.dmi'
	desc = "This is wheelchair. Say hello to your legs."
	icon_state = "invalidpimp"
	move_speed = 40
	anchored = 0
	density = 1
	flags = OPENCONTAINER
	//copypaste sorry
	/*var/obj/item/weapon/tank/air/cair = null
	var/obj/item/weapon/tank/jetpack/cjet = null
	var/obj/item/weapon/cell/ccell = null
	var/obj/item/device/radio/electropack/cpack = null // He-he-he
	var/obj/item/weapon/cable_coil/ccable = null */
	var/callme = "wheelchair"	//how do people refer to it?

/obj/structure/stool/bed/chair/wheelchair/New()
	handle_rotation()

/obj/structure/stool/bed/chair/wheelchair/examine()
	set src in usr
	usr << "\icon[src] This is [callme]. Say hello to your legs."
	/*if(ccell && cepack || ccable)
	    usr << "This wheelchair have some kind of engine." // Yep, i can be elecro wheelchair
	if(cair)
		usr << "\A [cair] is hanging on back of the [callme]."
	else if(cjet)
	    usr << "\A [cjet] is hanging on back of the [callme]."*/

/*/obj/structure/stool/bed/chair/wheelchair/attackby(obj/item/I, mob/user) // Adding some accesories
    if(istype(I, obj/item/weapon/tank))
		user << "<span class='notice'>You hook the air tank onto the [callme].</span>"
		update_icon()
		user.drop_item()
		I.loc = src
		cair = I
	else if(istype(W, /obj/item/weapon/tank/jetpack))
		user << "<span class='notice'>You hook the jetpack onto the [callme].</span>"
		update_icon()
		user.drop_item()
		W.loc = src
		cjet = W
	else if(istype(G, /obj/item/weapon/cable_coil))
		var/obj/item/weapon/cable_coil/C = G
		if(!wired)
			if(C.amount >= 2)
				C.use(2)
				wired = 1
				user << "<span class='notice'>You wrap some wires to [callme].</span>"
				G.loc = src
				ccable = G
				update_icon()
			else
				user << "<span class='notice'>There is not enough wire to attach in on [callme].</span>"
		else
			user << "<span class='notice'>[callme] are already some wires.</span>"

	else if(istype(A, /obj/item/weapon/cell))
		if(!wired)
			user << "<span class='notice'>[callme] need to be wired first.</span>"
		else if(!ccell)
			user.drop_item()
			A.loc = src
			ccell = A
			user << "<span class='notice'>You attach a cell to [callme].</span>"
			update_icon()
		else
			user << "<span class='notice'>[callme] already have a cell.</span>"

    else if(istype(B, /obj/item/device/radio/electropack))
		if(!wired)
			user << "<span class='notice'>[callme] need to be wired first.</span>"
		else if(!epack)
			user.drop_item()
			B.loc = src
			cpack = B
			user << "<span class='notice'>You attach a electropack to [callme].</span>"
			update_icon()
		else
			user << "<span class='notice'>One electropack per [callme], buddy.</span>"

/obj/structure/stool/bed/chair/wheelchair/attack_hand(mob/user) // Removing accesories
	if(cair)
		cair.loc = get_turf(user)
		user.put_in_hands(cair)
		cair = null
		updateicon()
	else if(cjet)
		cjet.loc = get_turf(user)
		user.put_in_hands(cjet)
		cjet = null
		updateicon()
	else if(istype(Q, /obj/item/weapon/wirecutters))
		if(ccell)
			ccell.loc = get_turf(user)
	      	user.put_in_hands(ccell)
	    	ccell = null
			user << "<span class='notice'>You cut the cell away from [callme].</span>"
			update_icon()
        if(epack)
			cpack.loc = get_turf(user)
	      	user.put_in_hands(cpack)
	    	cpack = null
			user << "<span class='notice'>You cut the electropack away from [callme].</span>"
			update_icon()
		if(wired)
			wired = 0
            ccable.loc = get_turf(user)
	    	user.put_in_hands(ccable)
	    	ccable = null
			user << "<span class='notice'>You cut the wires away from [callme].</span>"
			update_icon()
	else
		..() */


/obj/structure/stool/bed/chair/wheelchair/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	else
		step(src, direction)
		update_mob()
		handle_rotation()

/*/obj/structure/stool/bed/chair/wheelchair/verb/TurnOnJet() // WIP
    set name = "Toggle Jetpack"
	set category = "Object"
	set src in oview(1)
	var/onj = 0


/obj/structure/stool/bed/chair/wheelchair/verb/TurnOnEngi() // LETS ROLL
    set name = "Toggle Wheelchair engine"
	set category = "Object"
	set src in oview(1)
	var/on = 0
    if(ccell = A || ccable = G)
        if(on)
            on = 0
        else
            on = 1
            user << "<span class='notice'>You turned [on ? "on" : "off"] [callme] engine.</span>"
            move_speed = 20
    else if (cpack = b || ccable = G)
        if(on)
            on = 0
        else
            on = 1
            user << "<span class='notice'>You turned [on ? "on" : "off"] [callme] engine. Mmm... Smells like a fried chicken.</span>"
    else
        user << "<span class='notice'>What you are trying to do?</span>"

/obj/structure/stool/bed/chair/wheelchair/proc/shock()
	if(!on)
		return
	if(last_time + 50 > world.time)
		return
	last_time = world.time

	// special power handling
	var/area/Z = get_area(src)
	if(!isarea(Z))
		return
	if(!Z.powered(EQUIP))
		return
	Z.use_power(EQUIP, 5000)
	var/light = Z.power_light
	Z.updateicon()

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(12, 1, src)
	s.start()
	if(buckled_mob)
		buckled_mob.burn_skin(85)
		buckled_mob << "<span class='danger'>You feel a deep shock course through your body!</span>"
		sleep(1)
		buckled_mob.burn_skin(85)
		buckled_mob.Stun(600)
	visible_message("<span class='danger'>The [callme] off!</span>", "<span class='danger'>You hear a deep sharp shock!</span>")

	Z.power_light = light
	Z.updateicon() */

/obj/structure/stool/bed/chair/wheelchair/Move()
	..()
	if(buckled_mob)
		if(buckled_mob.buckled == src)
			buckled_mob.loc = loc

/obj/structure/stool/bed/chair/wheelchair/buckle_mob(mob/M, mob/user)
	if(M != user || !ismob(M) || get_dist(src, user) > 1 || user.restrained() || user.stat || M.buckled || istype(user, /mob/living/silicon))
		return

	unbuckle()

	M.visible_message(\
		"<span class='notice'>[M] tries to sit down onto the [callme]!</span>",\
		"<span class='notice'>You sit down on the [callme]!</span>")
	M.buckled = src
	M.loc = loc
	M.dir = dir
	M.update_canmove()
	buckled_mob = M
	update_mob()
	add_fingerprint(user)


/obj/structure/stool/bed/chair/wheelchair/unbuckle()
	if(buckled_mob)
		buckled_mob.pixel_x = 0
		buckled_mob.pixel_y = 0
	..()


/obj/structure/stool/bed/chair/wheelchair/handle_rotation()
	if(dir == SOUTH)
		layer = OBJ_LAYER
	else
		layer = FLY_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()


/obj/structure/stool/bed/chair/wheelchair/proc/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir
		switch(dir)
			if(SOUTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 4
			if(WEST)
				buckled_mob.pixel_x = -2
				buckled_mob.pixel_y = 4
			if(NORTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 4
			if(EAST)
				buckled_mob.pixel_x = 2
				buckled_mob.pixel_y = 4


/obj/structure/stool/bed/chair/wheelchair/bullet_act(var/obj/item/projectile/Proj)
	if(buckled_mob)
		if(prob(85))
			return buckled_mob.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the [callme]! Wow!</span>")
