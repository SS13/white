/obj/item/weapon/bedsheet/attackby(var/obj/item/weapon/O, mob/user as mob)
	if(istype(O) && O.sharp)
		usr << "You cutting bedsheet into some pieces of cloth..."
		if(do_after(user, 30))
			new /obj/item/stack/sheet/cloth(get_turf(src.loc, 3))
			del(src)
			return
 		..()