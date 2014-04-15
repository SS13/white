//Second part
/obj/item/weapon/bedsheet/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/shard) || istype(O, /obj/item/weapon/kitchenknife) || istype(O, /obj/item/weapon/scalpel))
		usr << "You start cutting bedsheet into several peaces..."
		if(do_after(user, 30))
			new /obj/item/sleeves( get_turf(usr.loc), 2 )
			new /obj/item/emblem( get_turf(usr.loc), 2 )
			new /obj/item/mask( get_turf(usr.loc), 2)
			del(src)
		return
	..()

/obj/item/weapon/bedsheet/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/sleeves))
		usr << "You start connecting sleeves to bedsheet..."
		if(do_after(user, 10))
			new /obj/item/part1( get_turf(usr.loc), 2 )
			del(I)
			del(src)
		return
	..()

/obj/item/part1/attackby(obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/mask))
		usr << "You start connecting mask to bedsheet..."
		if(do_after(user, 10))
			new /obj/item/part2( get_turf(usr.loc), 2 )
			del(A)
			del(src)
		return
	..()

/obj/item/part2/attackby(obj/item/Z as obj, mob/user as mob)
	if(istype(Z, /obj/item/emblem))
		usr << "You start connecting eblem to bedsheet..."
		if(do_after(user, 10))
			new /obj/item/part3( get_turf(usr.loc), 2 )
			del(Z)
			del(src)
		return
	..()

/obj/item/part3/attackby(obj/item/D as obj, mob/user as mob)
	if(istype(D, /obj/item/cotton))
		usr << "You start connecting looming costume..."
		if(do_after(user, 10))
			new /obj/item/clothing/head/kkc( get_turf(usr.loc), 2 )
			del(D)
			del(src)
		return
	..()

