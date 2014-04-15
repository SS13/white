/datum/wires/dnascanner
	holder_type = /obj/machinery/dna_scannernew
	wire_count = 5

var/const/DNASCAN_WIRE_RAD = 1
var/const/DNASCAN_WIRE_LOCK = 2
var/const/DNASCAN_WIRE_DATA = 4
var/const/DNASCAN_WIRE_RADDUR = 8
var/const/DNASCAN_WIRE_RADSTR = 16

/datum/wires/dnascanner/GetInteractWindow()
	var/obj/machinery/dna_scannernew/S = holder
	. += ..()
	. += "The scanner is [S.locked ? "locked" : "unlocked"].<BR>"
	. += "The radiation emitter is [S.pulsing ? "on" : "off"].<BR>"


/datum/wires/dnascanner/CanUse(var/mob/living/L)
	var/obj/machinery/dna_scannernew/S = holder
	if(S.open)
		return 1
	return 0

/datum/wires/dnascanner/UpdatePulsed(var/index)
	var/obj/machinery/dna_scannernew/S = holder

	switch(index)
		if(DNASCAN_WIRE_RAD)
			S.radpulse()
		if(DNASCAN_WIRE_LOCK)
			S.toggle_lock()
		if(DNASCAN_WIRE_RADDUR)
			S.radduration++
			if(S.radduration > 20) S.radduration -= 20
		if(DNASCAN_WIRE_RADSTR)
			S.radstrength++
			if(S.radstrength > 10) S.radstrength -= 10