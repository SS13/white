// JARLA, U ARE MAD! -- Jarlo
//Jail shit here


/obj/item/weapon/ore/sand //unusable.
	name = "sand"
	icon_state = "jailsand"	//Can't smelted.
	origin_tech = "materials=1"
	desc = "ON PATH TO MOTHERLAND!"
	w_class = 2.0


//paper spoon!
/obj/item/weapon/paperspoon
	icon = 'icons/obj/kitchen.dmi'
	name = "paper spoon"
	desc = "Jailers are so brutal."
	icon_state = "pspoon"
	attack_verb = list("attacked", "poked")
	var/drill_sound = 'sound/weapons/Genhit.ogg'
	flags = FPRINT | TABLEPASS | CONDUCT
	force = 4.0	//SUPER ROBUSTABLE, SRSLY!
	w_class = 2.0
	throwforce = 5.0
	throw_speed = 4
	throw_range = 4


//wall. Only for jail, lol
/turf/simulated/wall/r_wall/jail
	var/jailer = 0 //Nerf. Don't picking if over 1 jailer.
	var/sandcapas = 9
	var/last_act = 0
	proc/digproc(mob/user as mob)
		var/loca = usr.loc
		sleep(100)
		if (usr.loc == loca)
			sleep(100)
			if (usr.loc == loca)
				sleep(100)
				if (usr.loc == loca)
					sleep(100)
					if (usr.loc == loca)
						if (sandcapas == 1)
							src.jailer = 0
							src.ChangeTurf(/turf/simulated/floor/plating)
							var/turf/simulated/floor/F = src
							F.burn_tile()
							F.icon_state = "wall_thermite"
							usr << "\blue You finish picking the wall."
						else
							usr << "\blue You picked out some sand."
							var/obj/item/weapon/ore/sand/S = new(usr)
							S.loc = usr.loc	//recheck.
							sandcapas -= 1
							digproc() //again.
					else src.jailer = 0
				else src.jailer = 0
			else src.jailer = 0
		else src.jailer = 0


	attackby(obj/item/weapon/W as obj, mob/user as mob)
		..()//Fix.
		if (istype(W, /obj/item/weapon/paperspoon))
			var/obj/item/weapon/paperspoon/P = W
			if (jailer == 0)
				src.jailer = usr.key
				last_act = world.time
				playsound(user, P.drill_sound, 20, 1)
				usr << "\red You start picking a wall."
				digproc(user)
			else
				usr << "\red I can't. It's wall is busy."

/turf/simulated/wall/jail
	var/jailer = 0
	var/sandcapas = 3	//so easy to dig.
	var/last_act = 0
	proc/digproc(mob/user as mob)
		var/loca = usr.loc
		sleep(100)
		if (usr.loc == loca)
			sleep(100)
			if (usr.loc == loca)
				sleep(100)
				if (usr.loc == loca)
					sleep(100)
					if (usr.loc == loca)
						if (sandcapas == 1)
							src.jailer = 0
							src.ChangeTurf(/turf/simulated/floor/plating)
							var/turf/simulated/floor/F = src
							F.burn_tile()
							F.icon_state = "wall_thermite"
							usr << "\blue You finish picking the wall."
						else
							usr << "\blue You picked out some sand."
							var/obj/item/weapon/ore/sand/S = new(usr)
							S.loc = usr.loc	//recheck.
							sandcapas -= 1
							digproc() //again.
					else src.jailer = 0
				else src.jailer = 0
			else src.jailer = 0
		else src.jailer = 0


	attackby(obj/item/weapon/W as obj, mob/user as mob)
		..()
		if (istype(W, /obj/item/weapon/paperspoon))
			var/obj/item/weapon/paperspoon/P = W
			if (jailer == 0)
				src.jailer = usr.key
				last_act = world.time
				playsound(user, P.drill_sound, 20, 1)
				usr << "\red You start picking a wall."
				digproc(user)
			else
				usr << "\red I can't. It's wall is busy."

/obj/structure/sink/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/weapon/paper))
		new /obj/item/weapon/paperspoon( get_turf(usr.loc), 2 )
		usr << "\blue You \red make \blue paper \red spoon! \blue You \red are \blue mad!"	//lol
		del(O)
		return
	..()