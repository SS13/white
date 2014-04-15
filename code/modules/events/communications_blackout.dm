/datum/event/communications_blackout/announce()
	var/alert = pick(	"Обнаружены ионосферные аномалии. Неизбежен временный сбой телекоммуникационных систем. Пожалуйста, свяжитесь с вашим...*%fj00)`5vc-БЗЗЗ", \
						"Обнаружены ионосферные аномалии. Неизбежен временный сбой телекомму*3mga;b4;'1v¬-БЗЗЗ", \
						"Обнаружены ионосферные аномалии. Неизбежен врем#MCi46:5.;@63-БЗЗЗЗЗ", \
						"Обнаружены ионосферные ано'fZ\\kg5_0-БЗЗЗЗЗЗЗЗ", \
						"Обнаружены и%Ј MCayj^j<.3-БЗЗЗЗЗЗЗЗЗЗЗ", \
						"#4nd%;f4y6,>Ј%-БЗЗЗЗЗЗЗЗЗЗЗЗЗЗЗ")

	for(var/mob/living/silicon/ai/A in player_list)	//AIs are always aware of communication blackouts.
		A << "<br>"
		A << "<span class='warning'><b>[alert]</b></span>"
		A << "<br>"

	if(prob(30))	//most of the time, we don't want an announcement, so as to allow AIs to fake blackouts.
		command_alert(alert)


/datum/event/communications_blackout/start()
	for(var/obj/machinery/telecomms/T in telecomms_list)
		T.emp_act(1)