
/proc/communications_blackout(var/silent = 1)

	if(!silent)
		command_alert("Обнаружены ионосферные аномалии. Неизбежен временный сбой телекоммуникационных систем. Пожалуйста, свяжитесь с вашим...БЗЗЗ")
	else // AIs will always know if there's a comm blackout, rogue AIs could then lie about comm blackouts in the future while they shutdown comms
		for(var/mob/living/silicon/ai/A in player_list)
			A << "<br>"
			A << "<span class='warning'><b>Обнаружены ионосферные аномалии. Неизбежен временный сбой телекоммуникационных систем. Пожалуйста, свяжитесь с вашим...БЗЗЗ<b></span>"
			A << "<br>"
	for(var/obj/machinery/telecomms/T in telecomms_list)
		T.emp_act(1)
