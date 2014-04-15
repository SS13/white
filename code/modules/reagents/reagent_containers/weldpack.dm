/obj/item/weapon/reagent_containers/glass/backpack
	icon = 'icons/obj/storage.dmi'

	slot_flags = SLOT_BACK
	w_class = 4
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1, 5, 10, 25, 50, 100)
	volume = 500

/obj/item/weapon/reagent_containers/glass/backpack/weld
	name = "welding kit"
	desc = "A heavy-duty portable welding fuel carrier."
	icon_state = "welderpack"

/obj/item/weapon/reagent_containers/glass/backpack/weld/New()
	..()
	reagents.add_reagent("fuel", volume)

/obj/item/weapon/reagent_containers/glass/backpack/weld/proc/explode(var/mob/user)
	if(istype(user))
		message_admins("[key_name_admin(user)] triggered a welding kit explosion.")
		log_game("[key_name(user)] triggered a welding kit explosion.")
		user << "\red That was stupid of you."
	explosion(get_turf(src),-1,0,2)
	if(src)
		del(src)


/obj/item/weapon/reagent_containers/glass/backpack/water
	name = "water kit"
	desc = "A portable water carrier."
	icon_state = "waterpack"

/obj/item/weapon/reagent_containers/glass/backpack/water/New()
	..()
	reagents.add_reagent("water", volume)


/obj/item/weapon/reagent_containers/glass/backpack/cleaner
	name = "cleaner kit"
	desc = "When shit hits the fan..."
	icon_state = "cleanerpack"

/obj/item/weapon/reagent_containers/glass/backpack/cleaner/New()
	..()
	reagents.add_reagent("water", volume/5*4)
	reagents.add_reagent("cleaner", volume/5)