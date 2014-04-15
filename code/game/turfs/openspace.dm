//For new PermBrig!  --Jarlo

/turf/open
	name = ""
	intact = 0
	icon_state = "black"
	pathweight = 100000
	var/icon/darkoverlays = null
	var/turf/floorbelow
	mouse_opacity = 2
	Del()
		. = ..()

	Enter(var/atom/movable/AM)
		if (..())
			spawn(1)
				if(AM)
					AM.Move(locate(x, y, z - 1))
					if (istype(AM, /mob/living/carbon/human))
						var/mob/living/carbon/human/H = AM
						var/damage = rand(5,15)
						H.apply_damage(0.5*damage, BRUTE, "head")
						H.apply_damage(0.5*damage, BRUTE, "chest")
						H.apply_damage(damage, BRUTE, "l_leg")
						H.apply_damage(damage, BRUTE, "r_leg")
						H.apply_damage(0.25*damage, BRUTE, "l_arm")
						H.apply_damage(0.25*damage, BRUTE, "r_arm")
						H:weakened = max(H:weakened,2)
						H:updatehealth()
		return ..()
	attackby()
		//nothing

//	proc/update() 					//Later --Jarlo
//		if(!floorbelow) return


