/mob/living/simple_animal/metroid
	name = "pet metroid"
	desc = "A lovable, domesticated metroid."
	icon = 'icons/mob/metroids.dmi'
	icon_state = "grey baby metroid"
	icon_living = "grey baby metroid"
	icon_dead = "grey baby metroid dead"
	speak_emote = list("chirps")
	health = 100
	maxHealth = 100
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	emote_see = list("jiggles", "bounces in place")
	var/colour = "grey"

/mob/living/simple_animal/metroid/Bump(atom/movable/AM as mob|obj, yes)

	spawn( 0 )
		if ((!( yes ) || now_pushing))
			return
		now_pushing = 1
		if(ismob(AM))
			var/mob/tmob = AM
			if(istype(tmob, /mob/living/carbon/human) && (FAT in tmob.mutations))
				if(prob(70))
					src << "\red <B>You fail to push [tmob]'s fat ass out of the way.</B>"
					now_pushing = 0
					return
			if(!(tmob.status_flags & CANPUSH))
				now_pushing = 0
				return

			tmob.LAssailant = src
		now_pushing = 0
		..()
		if (!( istype(AM, /atom/movable) ))
			return
		if (!( now_pushing ))
			now_pushing = 1
			if (!( AM.anchored ))
				var/t = get_dir(src, AM)
				if (istype(AM, /obj/structure/window))
					if(AM:ini_dir == NORTHWEST || AM:ini_dir == NORTHEAST || AM:ini_dir == SOUTHWEST || AM:ini_dir == SOUTHEAST)
						for(var/obj/structure/window/win in get_step(AM,t))
							now_pushing = 0
							return
				step(AM, t)
			now_pushing = null
		return
	return

/mob/living/simple_animal/adultmetroid
	name = "pet metroid"
	desc = "A lovable, domesticated metroid."
	icon = 'icons/mob/metroids.dmi'
	health = 200
	maxHealth = 200
	icon_state = "grey adult metroid"
	icon_living = "grey adult metroid"
	icon_dead = "grey baby metroid dead"
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	emote_see = list("jiggles", "bounces in place")
	var/colour = "grey"

/mob/living/simple_animal/adultmetroid/New()
	..()
	overlays += "ametroid-:33"


/mob/living/simple_animal/metroid/adult/Die()
	var/mob/living/simple_animal/metroid/S1 = new /mob/living/simple_animal/metroid (src.loc)
	S1.icon_state = "[src.colour] baby metroid"
	S1.icon_living = "[src.colour] baby metroid"
	S1.icon_dead = "[src.colour] baby metroid dead"
	S1.colour = "[src.colour]"
	var/mob/living/simple_animal/metroid/S2 = new /mob/living/simple_animal/metroid (src.loc)
	S2.icon_state = "[src.colour] baby metroid"
	S2.icon_living = "[src.colour] baby metroid"
	S2.icon_dead = "[src.colour] baby metroid dead"
	S2.colour = "[src.colour]"
	del(src)