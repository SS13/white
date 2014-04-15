/mob/living/carbon/human/attack_hand(mob/living/carbon/human/M as mob)
	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return

	var/datum/organ/external/temp = M:organs_by_name["r_hand"]
	if (M.hand)
		temp = M:organs_by_name["l_hand"]
	if(temp && !temp.is_usable())
		M << "\red You can't use your [temp.display_name]."
		return

	..()

	if((M != src) && check_shields(0, M.name))
		visible_message("\red <B>[M] attempted to touch [src]!</B>")
		return 0

	//Some text don't want to display text macro "\himself"
	var/gender_text =""
	if (M.gender == MALE)
		gender_text = "himself"
	else //i.e. female
		gender_text = "herself"

	if(M.gloves && istype(M.gloves,/obj/item/clothing/gloves))
		var/obj/item/clothing/gloves/G = M.gloves
		if(G.cell)
			if(M.a_intent == "hurt")//Stungloves. Any contact will stun the alien.
				if(G.cell.charge >= 2500)
					G.cell.charge -= 2500
					if(M != src)
						visible_message("\red <B>[src] has been touched with the stun gloves by [M]!</B>")
						M.attack_log += text("\[[time_stamp()]\] <font color='red'>Stungloved [src.name] ([src.ckey])</font>")
						src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stungloved by [M.name] ([M.ckey])</font>")

						//log_admin("ATTACK: [src] ([src.ckey]) stungloved [M] ([M.ckey]).")
						message_admins("ATTACK: [M] ([M.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) stungloved [src] ([src.ckey]).", 0)
						log_attack("[M] ([M.ckey]) stungloved [src] ([src.ckey])")
					else
						visible_message("\red <B>[src] has been touched with the stun gloves by \himself!</B>")
						src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stungloved by [gender_text]</font>")

						//log_admin("ATTACK: [src] ([src.ckey]) stungloved [M] ([M.ckey]).")
						message_admins("ATTACK: [src] ([src.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) stungloved [gender_text].", 0)
						log_attack("[src] ([src.ckey]) stungloved [gender_text]")

					var/armorblock = run_armor_check(M.zone_sel.selecting, "energy")
					apply_effects(5,5,0,0,5,0,0,armorblock)
					return 1
				else
					M << "\red Not enough charge! "
					if(M != src)
						visible_message("\red <B>[src] has been touched with the stun gloves by [M]!</B>")
						message_admins("ATTACK: [M] ([M.ckey](<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) was trying to stunglove [src] ([src.ckey]).", 0)
						log_attack("[M] ([M.ckey] was trying to stunglove [src] ([src.ckey])")
					else
						visible_message("\red <B>[src] has been touched with the stun gloves by \himself!</B>")
						message_admins("ATTACK: [src] ([src.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) was trying to stunglove [gender_text].", 0)
						log_attack("[src] ([src.ckey]) was trying to stunglove [gender_text]")
				return

		if(istype(M.gloves , /obj/item/clothing/gloves/boxing/hologlove))

			/*
			if (M != src)
				M.attack_log += text("\[[time_stamp()]\] <font color='red'>[M.species.attack_verb]ed [src.name] ([src.ckey])</font>")
				src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been [M.species.attack_verb]ed by [M.name] ([M.ckey])</font>")

				message_admins("ATTACK: [M.name] ([M.ckey])(<A HREF='?src=\ref[src];adminplayerobservejump=\ref[M]'>JMP</A>) [M.species.attack_verb]ed [src.name] ([src.ckey])",0)
				log_attack("[M.name] ([M.ckey]) [M.species.attack_verb]ed [src.name] ([src.ckey])")
			else
				src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been [M.species.attack_verb]ed by [gender_text]</font>")

				message_admins("ATTACK: [src.name] ([src.ckey])(<A HREF='?src=\ref[src];adminplayerobservejump=\ref[src]'>JMP</A>) [src.species.attack_verb]ed [gender_text]",0)
				log_attack("[src.name] ([src.ckey]) [src.species.attack_verb]ed [gender_text]")
			*/

			var/damage = rand(0, 9)
			if(!damage)
				playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
				if(M != src)
					visible_message("\red <B>[M] has attempted to punch [src]!</B>")
				else
					visible_message("\red <B>[src] has attempted to punch \himself!</B>")
				return 0
			var/datum/organ/external/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee")

			if(HULK in M.mutations)			damage += 5

			playsound(loc, "punch", 25, 1, -1)

			if(M != src)
				visible_message("\red <B>[M] has punched [src]!</B>")
			else
				visible_message("\red <B>[src] has punched \himself!</B>")

			apply_damage(damage, HALLOSS, affecting, armor_block)
			if(damage >= 9)
				if(M != src)
					visible_message("\red <B>[M] has weakened [src]!</B>")
				else
					visible_message("\red <B>[src] has weakened \himself!</B>")
				apply_effect(4, WEAKEN, armor_block)

			return
	else
		if(istype(M,/mob/living/carbon))
//			log_debug("No gloves, [M] is trying to infect [src]")
			M.spread_disease_to(src, "Contact")


	switch(M.a_intent)
		if("help")
			if(health >= config.health_threshold_crit)
				help_shake_act(M)
				return 1
//			if(M.health < -75)	return 0

			if((M.head && (M.head.flags & HEADCOVERSMOUTH)) || (M.wear_mask && (M.wear_mask.flags & MASKCOVERSMOUTH)))
				M << "\blue <B>Remove your mask!</B>"
				return 0
			if((head && (head.flags & HEADCOVERSMOUTH)) || (wear_mask && (wear_mask.flags & MASKCOVERSMOUTH)))
				M << "\blue <B>Remove his mask!</B>"
				return 0

			var/obj/effect/equip_e/human/O = new /obj/effect/equip_e/human()
			O.source = M
			O.target = src
			O.s_loc = M.loc
			O.t_loc = loc
			O.place = "CPR"
			requests += O
			spawn(0)
				O.process()
			return 1

		if("grab")
			if(M == src)	return 0
			if(w_uniform)	w_uniform.add_fingerprint(M)
			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab(M, M, src)

			M.put_in_active_hand(G)

			grabbed_by += G
			G.synch()
			LAssailant = M

			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			visible_message("\red [M] has grabbed [src] passively!")
			return 1

		if("hurt")

			if (M != src)
				M.attack_log += text("\[[time_stamp()]\] <font color='red'>[M.species.attack_verb]ed [src.name] ([src.ckey])</font>")
				src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been [M.species.attack_verb]ed by [M.name] ([M.ckey])</font>")

				message_admins("ATTACK: [M.name] ([M.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[M]'>JMP</A>) [M.species.attack_verb]ed [src.name] ([src.ckey])",0)
				log_attack("[M.name] ([M.ckey]) [M.species.attack_verb]ed [src.name] ([src.ckey])")
			else
				src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been [M.species.attack_verb]ed by [gender_text]</font>")

				message_admins("ATTACK: [src.name] ([src.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) [src.species.attack_verb]ed [gender_text]",0)
				log_attack("[src.name] ([src.ckey]) [src.species.attack_verb]ed [gender_text]")

			var/damage = rand(0, 5)//BS12 EDIT
			if(!damage)
				if(M.species.attack_verb == "punch")
					playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
				else
					playsound(loc, 'sound/weapons/slashmiss.ogg', 25, 1, -1)

				if (M != src)
					visible_message("\red <B>[M] has attempted to [M.species.attack_verb] [src]!</B>")
				else
					visible_message("\red <B>[src] has attempted to [src.species.attack_verb] \himself!</B>")
				return 0


			var/datum/organ/external/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee")

			if(HULK in M.mutations)			damage += 5


			if(M.species.attack_verb == "punch")
				playsound(loc, "punch", 25, 1, -1)
			else
				playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)

			if (M != src)
				visible_message("\red <B>[M] has [M.species.attack_verb]ed [src]!</B>")
			else
				visible_message("\red <B>[src] has [src.species.attack_verb]ed \himself!</B>")
			//Rearranged, so claws don't increase weaken chance.
			if(damage >= 5 && prob(50))
				if (M != src)
					visible_message("\red <B>[M] has weakened [src]!</B>")
				else
					visible_message("\red <B>[src] has weakened \himself!</B>")
				apply_effect(2, WEAKEN, armor_block)

			if(M.species.attack_verb != "punch")	damage += 5
			apply_damage(damage, BRUTE, affecting, armor_block)


		if("disarm")
			if (M != src)
				M.attack_log += text("\[[time_stamp()]\] <font color='red'>Disarmed [src.name] ([src.ckey])</font>")
				src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been disarmed by [M.name] ([M.ckey])</font>")

				message_admins("ATTACK: [M.name] ([M.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[M]'>JMP</A>) disarmed [src.name] ([src.ckey])",0)
				log_attack("[M.name] ([M.ckey]) disarmed [src.name] ([src.ckey])")
			else
				src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been disarmed by [gender_text]</font>")

				message_admins("ATTACK: [src.name] ([src.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) disarmed [gender_text]",0)
				log_attack("[src.name] ([src.ckey]) disarmed [gender_text]")


			if(w_uniform)
				w_uniform.add_fingerprint(M)
			var/datum/organ/external/affecting = get_organ(ran_zone(M.zone_sel.selecting))

			if (istype(r_hand,/obj/item/weapon/gun) || istype(l_hand,/obj/item/weapon/gun))
				var/obj/item/weapon/gun/W = null
				var/chance = 0

				if (istype(l_hand,/obj/item/weapon/gun))
					W = l_hand
					chance = hand ? 40 : 20

				if (istype(r_hand,/obj/item/weapon/gun))
					W = r_hand
					chance = !hand ? 40 : 20

				if (prob(chance))
					visible_message("<spawn class=danger>[src]'s [W] goes off during struggle!")
					var/list/turfs = list()
					for(var/turf/T in view())
						turfs += T
					var/turf/target = pick(turfs)
					return W.afterattack(target,src)

			var/randn = rand(1, 100)
			if (randn <= 25)
				apply_effect(4, WEAKEN, run_armor_check(affecting, "melee"))
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				if (M != src)
					visible_message("\red <B>[M] has pushed [src]!</B>")
				else
					visible_message("\red <B>[src] has pushed \himself!</B>")
				return

			var/talked = 0	// BubbleWrap

			if(randn <= 60)
				//BubbleWrap: Disarming breaks a pull
				if(pulling)
					if (M != src)
						visible_message("\red <b>[M] has broken [src]'s grip on [pulling]!</B>")
					else
						visible_message("\red <b>[src] has broken \his grip on [pulling]!</B>")
					talked = 1
					stop_pulling()

				//BubbleWrap: Disarming also breaks a grab - this will also stop someone being choked, won't it?
				if(istype(l_hand, /obj/item/weapon/grab))
					var/obj/item/weapon/grab/lgrab = l_hand
					if(lgrab.affecting)
						if (M != src)
							visible_message("\red <b>[M] has broken [src]'s grip on [lgrab.affecting]!</B>")
						else
							visible_message("\red <b>[src] has broken \his grip on [lgrab.affecting]!</B>")
						talked = 1
					spawn(1)
						del(lgrab)
				if(istype(r_hand, /obj/item/weapon/grab))
					var/obj/item/weapon/grab/rgrab = r_hand
					if(rgrab.affecting)
						if (M != src)
							visible_message("\red <b>[M] has broken [src]'s grip on [rgrab.affecting]!</B>")
						else
							visible_message("\red <b>[src] has broken \his grip on [rgrab.affecting]!</B>")
						talked = 1
					spawn(1)
						del(rgrab)
				//End BubbleWrap

				if(!talked)	//BubbleWrap
					drop_item()
					if (M != src)
						visible_message("\red <B>[M] has disarmed [src]!</B>")
					else
						visible_message("\red <B>[src] has disarmed \himself!</B>")
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				return


			playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
			if (M != src)
				visible_message("\red <B>[M] attempted to disarm [src]!</B>")
			else
				visible_message("\red <B>[src] attempted to disarm \himself!</B>")
	return

/mob/living/carbon/human/proc/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, inrange, params)
	return
