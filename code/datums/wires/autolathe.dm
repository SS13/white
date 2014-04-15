/datum/wires/rdm
	holder_type = /obj/machinery/r_n_d
	wire_count = 10

var/const/RDM_WIRE_HACKED = 1
var/const/RDM_WIRE_POWER = 2
var/const/RDM_WIRE_SHOCK = 4

/datum/wires/rdm/GetInteractWindow()
	var/obj/machinery/r_n_d/A = holder
	. += ..()

	. += text("The red light is [A.disabled ? "off" : "on"].<BR>")
	. += text("The green light is [A.shocked ? "off" : "on"].<BR>")
	. += text("The blue light is [A.hacked ? "off" : "on"].<BR>")


/datum/wires/rdm/CanUse(var/mob/living/L)
	var/obj/machinery/r_n_d/A = holder
	if(A.opened)
		return 1
	return 0

/datum/wires/rdm/UpdatePulsed(var/index)
	var/obj/machinery/r_n_d/A = holder

	switch(index)
		if(RDM_WIRE_HACKED)
			A.hacked = !A.hacked
			spawn(100)
				A.hacked = !A.hacked

		if (RDM_WIRE_POWER)
			A.disabled = !A.disabled
			A.shock(usr,50)
			spawn(100)
				A.disabled = !A.disabled

		if (RDM_WIRE_SHOCK)
			A.shocked = !A.shocked
			A.shock(usr,50)
			spawn(100)
				A.shocked = !A.shocked

	A.updateDialog()


/datum/wires/rdm/UpdateCut(var/index, var/mended)
	var/obj/machinery/r_n_d/A = holder

	switch(index)
		if(RDM_WIRE_HACKED)
			A.hacked = !A.hacked

		if (RDM_WIRE_POWER)
			A.disabled = !A.disabled
			A.shock(usr,50)

		if (RDM_WIRE_SHOCK)
			A.shocked = !A.shocked
			A.shock(usr,50)

	A.updateDialog()



/datum/wires/rdm/autolathe
	holder_type = /obj/machinery/autolathe

/datum/wires/rdm/autolathe/CanUse(var/mob/living/L)
	var/obj/machinery/autolathe/A = holder
	if(A.opened)
		return 1
	return 0

/datum/wires/rdm/autolathe/UpdatePulsed(var/index)
	var/obj/machinery/autolathe/A = holder

	switch(index)
		if(RDM_WIRE_HACKED)
			A.hacked = !A.hacked
			spawn(100)
				A.hacked = !A.hacked

		if (RDM_WIRE_POWER)
			A.disabled = !A.disabled
			A.shock(usr,50)
			spawn(100)
				A.disabled = !A.disabled

		if (RDM_WIRE_SHOCK)
			A.shocked = !A.shocked
			A.shock(usr,50)
			spawn(100)
				A.shocked = !A.shocked

	A.updateDialog()


/datum/wires/rdm/autolathe/UpdateCut(var/index, var/mended)
	var/obj/machinery/autolathe/A = holder

	switch(index)
		if(RDM_WIRE_HACKED)
			A.hacked = !A.hacked

		if (RDM_WIRE_POWER)
			A.disabled = !A.disabled
			A.shock(usr,50)

		if (RDM_WIRE_SHOCK)
			A.shocked = !A.shocked
			A.shock(usr,50)

	A.updateDialog()