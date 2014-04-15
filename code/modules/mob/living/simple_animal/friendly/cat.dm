//Cat
/mob/living/simple_animal/cat
	name = "cat"
	desc = "A domesticated, feline pet. Has a tendency to adopt crewmembers."
	icon_state = "cat"
	icon_living = "cat"
	icon_dead = "cat_dead"
	speak = list("Meow!","Esp!","Purr!","HSSSSS")
	speak_emote = list("purrs", "meows")
	emote_hear = list("meows","mews")
	emote_see = list("shakes its head", "shivers")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"
	var/turns_since_scan = 0
	var/mob/living/simple_animal/mouse/movement_target
	min_oxy = 16 //Require atleast 16kPA oxygen
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323	//Above 50 Degrees Celcius

/mob/living/simple_animal/cat/Life()
	//MICE!
	if((src.loc) && isturf(src.loc))
		if(!stat && !resting && !buckled)
			for(var/mob/living/simple_animal/mouse/M in view(1,src))
				if(!M.stat)
					M.splat()
					emote(pick("\red splats the [M]!","\red toys with the [M]","worries the [M]"))
					movement_target = null
					stop_automated_movement = 0
					break

	..()

	for(var/mob/living/simple_animal/mouse/snack in oview(src, 3))
		if(prob(15))
			emote(pick("hisses and spits!","mrowls fiercely!","eyes [snack] hungrily."))
		break

	if(!stat && !resting && !buckled)
		turns_since_scan++
		if(turns_since_scan > 5)
			walk_to(src,0)
			turns_since_scan = 0
			if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
				movement_target = null
				stop_automated_movement = 0
			if( !movement_target || !(movement_target.loc in oview(src, 5)) )
				movement_target = null
				stop_automated_movement = 0
				for(var/mob/living/simple_animal/mouse/snack in oview(src,5))
					if(isturf(snack.loc) && !snack.stat)
						movement_target = snack
						break
			if(movement_target)
				stop_automated_movement = 1
				walk_to(src,movement_target,0.5,10)

//RUNTIME IS ALIVE! SQUEEEEEEEE~
/mob/living/simple_animal/cat/Runtime
	name = "Runtime"
	desc = "Its fur has the look and feel of velvet, and it's tail quivers occasionally."

/mob/living/simple_animal/cat/Runtime/cat2
	name = "Erwin"
	var/mob/living/carbon/human/host = null
	icon_state = "Dark_cat"
	icon_living = "Dark_cat"
	icon_dead = "Dark_cat_dead"


/mob/living/simple_animal/cat/Runtime/cat2/verb/call_cat()
	set name = "Call Erwin"
	set src in oview()
	if(host&&usr==host)
		stop_automated_movement = 1
		movement_target = host

/mob/living/simple_animal/cat/Runtime/cat2/verb/halt_cat()
	set name = "Stay Here"
	set src in oview()
	if(host&&usr==host)
		movement_target = 0
		stop_automated_movement = 0

/mob/living/simple_animal/cat/say(var/message)

	if (length(message) >= 2)
		if (copytext(message, 1, 3) == ":a")
			message = copytext(message, 3)
			message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))
			if (stat == 2)
				return say_dead(message)
			else
				alien_talk(message)
		else
			if (copytext(message, 1, 2) != "*" && !stat)
				playsound(loc, "meaw", 25, 1, 1)//So aliens can hiss while they hiss yo/N
			return ..(message)