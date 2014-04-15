////////////////////////////////////////////////////////////////////////
//////////////////////////////////*MEDICAL*/////////////////////////////Test
////////////////////////////////////////////////////////////////////////

//Gauze by rusty weapon
//Shard + jumpsuit = 3-5 bruise pack.

/obj/item/weapon/shard/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/clothing/under))
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		usr << "\blue You make some gauze from this jumpsuit and this shard."
		user.visible_message("\red [user] cut jumpsuit into several pieces.")
		del(O)
		return
	..()

/obj/item/weapon/scalpel/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/clothing/under))
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		usr << "\blue You make some gauze from this jumpsuit and this scalpel."
		user.visible_message("\red [user] cut jumpsuit into several pieces.")
		del(O)
		return
	..()

/obj/item/weapon/kitchenknife/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/clothing/under))
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		new /obj/item/stack/medical/bruise_pack/medical_craft( get_turf(usr.loc), 2 )
		usr << "\blue You make some gauze from this jumpsuit and this knife."
		user.visible_message("\red [user] cut jumpsuit into several pieces.")
		del(O)
		return
	..()
