/obj/item/weapon/melee/baton
	name = "stun baton"
	desc = "A stun baton for incapacitating people with."
	icon_state = "stunbaton"
	item_state = "baton"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 7
	w_class = 3
	write_log = 0
	show_atk_msg = 0
	var/charges = 10
	var/status = 0
	var/mob/foundmob = "" //Used in throwing proc.

	origin_tech = "combat=2"

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is putting the live [src.name] in \his mouth! It looks like \he's trying to commit suicide.</b>"
		return (FIRELOSS)

/obj/item/weapon/melee/baton/update_icon()
	if(status)
		icon_state = "stunbaton_active"
	else
		icon_state = "stunbaton"

/obj/item/weapon/melee/baton/attack_self(mob/user as mob)
	if(status && (CLUMSY in user.mutations) && prob(50))
		user << "\red You grab the [src] on the wrong side."
		user.Weaken(30)
		charges--
		if(charges < 1)
			status = 0
			update_icon()
		return
	if(charges > 0)
		status = !status
		user << "<span class='notice'>\The [src] is now [status ? "on" : "off"].</span>"
		playsound(src.loc, "sparks", 75, 1, -1)
		update_icon()
	else
		status = 0
		user << "<span class='warning'>\The [src] is out of charge.</span>"
	add_fingerprint(user)

/obj/item/weapon/melee/baton/attack(mob/M as mob, mob/user as mob)
	if(status && (CLUMSY in user.mutations) && prob(50))
		user << "<span class='danger'>You accidentally hit yourself with the [src]!</span>"
		user.Weaken(30)
		charges--
		if(charges < 1)
			status = 0
			update_icon()
		return

	var/mob/living/carbon/human/H = M
	if(isrobot(M))
		..()
		return

	//Some text don't want to display text macro "\himself"
	var/gender_text =""
	if (user.gender == MALE)
		gender_text = "himself"
	else //i.e. female
		gender_text = "herself"

	var/victim = ""
	var/victim_full = ""
	if (H != user)
		victim = "[H]"
		victim_full = "[H.name] ([H.ckey])"
	else
		victim = "[gender_text]"
		victim_full = "[gender_text]"

	var/beaten = 0
	if(user.a_intent == "hurt")
		if(!..()) return
		//H.apply_effect(5, WEAKEN, 0)
		beaten = 1
		playsound(src.loc, "swing_hit", 50, 1, -1)
	else if(!status)
		H.visible_message("<span class='warning'>[M] has been prodded with the [src] by [victim]. Luckily it was off.</span>")
		return

	if(status)
		H.apply_effect(10, STUN, 0)
		H.apply_effect(10, WEAKEN, 0)
		H.apply_effect(10, STUTTER, 0)
		user.lastattacked = M
		H.lastattacker = user
		if(isrobot(src.loc))
			var/mob/living/silicon/robot/R = src.loc
			if(R && R.cell)
				R.cell.use(50)
		else
			charges--

		playsound(src.loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		if(charges < 1)
			status = 0
			update_icon()

	//Messages and logs
	if (status || beaten)
		var/atk_text = ""
		var/atk_text_cap = ""
		var/atk_text_cap_user = ""
		if (beaten)
			atk_text = "beaten"
			atk_text_cap = "Beaten"
			atk_text_cap_user = "Beat"
			if (status)
				atk_text = "beaten and stunned"
				atk_text_cap = "Beaten and stunned"
				atk_text_cap_user = "Beat and stunned"
		else
			atk_text = "stunned"
			atk_text_cap = "Stunned"
			atk_text_cap_user = "Stunned"

		if(H != user)
			H.visible_message("<span class='danger'>[M] has been [atk_text] with the [src] by [user]!</span>")
		else
			H.visible_message("<span class='danger'>[M] has been [atk_text] with the [src] by [gender_text]!</span>")

		if(H != user)
			H.attack_log += "\[[time_stamp()]\]<font color='orange'> [atk_text_cap] by [user] ([user.ckey]) with [src.name]</font>"
		user.attack_log += "\[[time_stamp()]\]<font color='red'> [atk_text_cap_user] [victim_full] with [src.name]</font>"
		message_admins("ATTACK: [user] ([user.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[user]'>JMP</A>) [atk_text] [victim_full] with [src].", 0)
		log_attack("[user.name] ([user.ckey]) [atk_text] [victim_full] with [src.name]")

	add_fingerprint(user)

/obj/item/weapon/melee/baton/throw_impact(atom/hit_atom)
	if (prob(50))
		if(istype(hit_atom, /mob/living))
			var/mob/living/carbon/human/H = hit_atom
			if(status)
				H.apply_effect(10, STUN, 0)
				H.apply_effect(10, WEAKEN, 0)
				H.apply_effect(10, STUTTER, 0)
				charges--

				for(var/mob/M in player_list) if(M.key == src.fingerprintslast)
					foundmob = M
					break

				H.visible_message("<span class='danger'>[src], thrown by [foundmob.name], strikes [H] and stuns them!</span>")

				H.attack_log += "\[[time_stamp()]\]<font color='orange'> Stunned by thrown [src.name] last touched by ([src.fingerprintslast])</font>"
				log_attack("Flying [src.name], last touched by ([src.fingerprintslast]) stunned [H.name] ([H.ckey])" )

				return
	return ..()

/obj/item/weapon/melee/baton/emp_act(severity)
	switch(severity)
		if(1)
			charges = 0
		if(2)
			charges = max(0, charges - 5)
	if(charges < 1)
		status = 0
		update_icon()

//Makeshift stun baton.
/obj/item/weapon/melee/baton/stunprod
	name = "stunprod"
	desc = "An improvised stun baton."
	icon_state = "stunprod"
	item_state = "baton"
	charges = 3
	force = 3
	var/hitminus = 2500
	var/obj/item/weapon/cell/prodcell = null
	throwforce = 10
	slot_flags = SLOT_BELT

/obj/item/weapon/melee/baton/stunprod/update_icon()
	if(status)
		icon_state = "stunprod_active"
	else
		icon_state = "stunprod"


/obj/item/weapon/melee/baton/stunprod/attack()
	..()
	if (status && prodcell >= 2500)
		charges = 3
		prodcell = prodcell - hitminus
	else if (!status && prodcell >= 2500)
		charges = 2
		update_icon()
	else if (status && prodcell < 2500)
		status = 0
		charges = 0
		usr << "<span class='warning'>\The [src] is out of charge.</span>"
		update_icon()
	else if (!status && prodcell < 2500)
		charges = 0
		status = 0
		usr << "<span class='warning'>\The [src] is out of charge.</span>"
		update_icon()