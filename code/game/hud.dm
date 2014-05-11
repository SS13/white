//Upper left action buttons, displayed when you pick up an item that has this enabled.
#define ui_action_slot1 "1:6,14:26"
#define ui_action_slot2 "2:8,14:26"
#define ui_action_slot3 "3:10,14:26"
#define ui_action_slot4 "4:12,14:26"
#define ui_action_slot5 "5:14,14:26"

//Lower left, persistant menu
#define ui_inventory "1:6,1:5"

//Lower center, persistant menu
#define ui_sstore1 "3:10,1:5"
#define ui_id "4:12,1:5"
#define ui_belt "5:14,1:5"
#define ui_back "6:14,1:5"
#define ui_rhand "7:16,1:5"
#define ui_lhand "8:16,1:5"
#define ui_equip "7:16,2:5"
#define ui_swaphand1 "7:16,2:5"
#define ui_swaphand2 "8:16,2:5"
#define ui_storage1 "9:18,1:5"
#define ui_storage2 "10:20,1:5"

#define ui_alien_head "4:12,1:5"	//aliens
#define ui_alien_oclothing "5:14,1:5"	//aliens

#define ui_inv1 "6:16,1:5"			//borgs
#define ui_inv2 "7:16,1:5"			//borgs
#define ui_inv3 "8:16,1:5"			//borgs
#define ui_borg_store "9:16,1:5"	//borgs

#define ui_monkey_mask "5:14,1:5"	//monkey
#define ui_monkey_back "6:14,1:5"	//monkey

//Lower right, persistant menu
#define ui_dropbutton "11:22,1:5"
#define ui_drop_throw "14:28,2:7"
#define ui_pull_resist "13:26,2:7"
#define ui_acti "13:26,1:5"
#define ui_movi "12:24,1:5"
#define ui_zonesel "14:28,1:5"
#define ui_acti_alt "14:28,1:5" //alternative intent switcher for when the interface is hidden (F12)

#define ui_borg_pull "12:24,2:7"
#define ui_borg_module "13:26,2:7"
#define ui_borg_panel "14:28,2:7"

//Gun buttons
/*#define ui_gun1 "13:26,3:7"
#define ui_gun2 "14:28, 4:7"
#define ui_gun3 "13:26,4:7"
#define ui_gun_select "14:28,3:7"*/

//Upper-middle right (damage indicators)
#define ui_toxin "14:28,13:27"
#define ui_fire "14:28,12:25"
#define ui_oxygen "14:28,11:23"
#define ui_pressure "14:28,10:21"

#define ui_alien_toxin "14:28,13:25"
#define ui_alien_fire "14:28,12:25"
#define ui_alien_oxygen "14:28,11:25"

//Middle right (status indicators)
#define ui_nutrition "14:28,5:11"
#define ui_temp "14:28,6:13"
#define ui_health "14:28,7:15"
#define ui_internal "14:28,8:17"
									//borgs
#define ui_borg_health "14:28,6:13" //borgs have the health display where humans have the pressure damage indicator.
#define ui_alien_health "14:28,6:13" //aliens have the health display where humans have the pressure damage indicator.

//Pop-up inventory
#define ui_shoes "2:8,1:5"

#define ui_iclothing "1:6,2:7"
#define ui_oclothing "2:8,2:7"
#define ui_gloves "3:10,2:7"

#define ui_glasses "1:6,3:9"
#define ui_mask "2:8,3:9"
#define ui_ears "3:10,3:9"

#define ui_head "2:8,4:11"

//Intent small buttons
#define ui_help_small "12:8,1:1"
#define ui_disarm_small "12:15,1:18"
#define ui_grab_small "12:32,1:18"
#define ui_harm_small "12:39,1:1"

//#define ui_swapbutton "6:-16,1:5" //Unused

//#define ui_headset "SOUTH,8"
#define ui_hand "6:14,1:5"
#define ui_hstore1 "5,5"
//#define ui_resist "EAST+1,SOUTH-1"
#define ui_sleep "EAST+1, NORTH-13"
#define ui_rest "EAST+1, NORTH-14"


#define ui_iarrowleft "SOUTH-1,11"
#define ui_iarrowright "SOUTH-1,13"

var/datum/global_hud/global_hud = new()

/datum/global_hud
	var/obj/screen/druggy
	var/obj/screen/blurry
	var/list/vimpaired
	var/list/darkMask

	New()
		//420erryday psychedellic colours screen overlay for when you are high
		druggy = new /obj/screen()
		druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
		druggy.icon_state = "druggy"
		druggy.layer = 17
		druggy.mouse_opacity = 0

		//that white blurry effect you get when you eyes are damaged
		blurry = new /obj/screen()
		blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
		blurry.icon_state = "blurry"
		blurry.layer = 17
		blurry.mouse_opacity = 0

		var/obj/screen/O
		var/i
		//that nasty looking dither you  get when you're short-sighted
		vimpaired = newlist(/obj/screen,/obj/screen,/obj/screen,/obj/screen)
		O = vimpaired[1]
		O.screen_loc = "1,1 to 5,15"
		O = vimpaired[2]
		O.screen_loc = "5,1 to 10,5"
		O = vimpaired[3]
		O.screen_loc = "6,11 to 10,15"
		O = vimpaired[4]
		O.screen_loc = "11,1 to 15,15"

		//welding mask overlay black/dither
		darkMask = newlist(/obj/screen,/obj/screen,/obj/screen,/obj/screen,/obj/screen,/obj/screen,/obj/screen,/obj/screen)
		O = darkMask[1]
		O.screen_loc = "3,3 to 5,13"
		O = darkMask[2]
		O.screen_loc = "5,3 to 10,5"
		O = darkMask[3]
		O.screen_loc = "6,11 to 10,13"
		O = darkMask[4]
		O.screen_loc = "11,3 to 13,13"
		O = darkMask[5]
		O.screen_loc = "1,1 to 15,2"
		O = darkMask[6]
		O.screen_loc = "1,3 to 2,15"
		O = darkMask[7]
		O.screen_loc = "14,3 to 15,15"
		O = darkMask[8]
		O.screen_loc = "3,14 to 13,15"

		for(i=1,i<=4,i++)
			O = vimpaired[i]
			O.icon_state = "dither50"
			O.layer = 17
			O.mouse_opacity = 0

			O = darkMask[i]
			O.icon_state = "dither50"
			O.layer = 17
			O.mouse_opacity = 0

		for(i=5,i<=8,i++)
			O = darkMask[i]
			O.icon_state = "black"
			O.layer = 17
			O.mouse_opacity = 0

/datum/hud_special
	var/datum/hud/myhud
	var/list/locations = list()
	var/list/hideable = list()

	New(var/datum/hud/owner)
		myhud = owner

	proc/hidden_inventory_update()
		return 0

	proc/persistant_inventory_update()
		return 0


/datum/hud
	var/mob/mymob

	var/hud_shown = 1			//Used for the HUD toggle (F12)
	var/inventory_shown = 1		//the inventory
	var/show_intent_icons = 0
	var/hotkey_ui_hidden = 0	//This is to hide the buttons that can be used via hotkeys. (hotkeybuttons list of buttons)

	var/obj/screen/r_hand_hud_object
	var/obj/screen/l_hand_hud_object
	var/obj/screen/action_intent
	var/obj/screen/move_intent
	var/obj/screen/swap_hand

	var/list/adding
	var/list/other
	var/list/obj/screen/hotkeybuttons

	var/list/obj/screen/item_action/item_action_list //Used for the item action ui buttons.

	var/obj/screen/grab_intent
	var/obj/screen/hurt_intent
	var/obj/screen/disarm_intent
	var/obj/screen/help_intent

	var/datum/hud_special/special

/datum/hud/New(mob/owner)
	mymob = owner
	instantiate()
	..()
	return

/datum/hud/proc/get_slot_loc(var/slot)
	if(special && special.locations[slot])
		return special.locations[slot]

	switch(slot)
		if("mask") return ui_mask
		if("oclothing") return ui_oclothing
		if("iclothing") return ui_iclothing

		if("sstore1") return ui_sstore1
		if("id") return ui_id
		if("belt") return ui_belt
		if("back") return ui_back

		if("rhand") return ui_rhand
		if("lhand") return ui_lhand

		if("storage1") return ui_storage1
		if("storage2") return ui_storage2

		if("shoes") return ui_shoes
		if("head") return ui_head
		if("gloves") return ui_gloves
		if("ears") return ui_ears
		if("glasses") return ui_glasses

		if("acti") return ui_acti

/mob/living/carbon/human/proc/get_slot_loc(var/slot)
	if(hud_used)
		return hud_used.get_slot_loc(slot)

	switch(slot)
		if("mask") return ui_mask
		if("oclothing") return ui_oclothing
		if("iclothing") return ui_iclothing

		if("sstore1") return ui_sstore1
		if("id") return ui_id
		if("belt") return ui_belt
		if("back") return ui_back

		if("rhand") return ui_rhand
		if("lhand") return ui_lhand

		if("storage1") return ui_storage1
		if("storage2") return ui_storage2

		if("shoes") return ui_shoes
		if("head") return ui_head
		if("gloves") return ui_gloves
		if("ears") return ui_ears
		if("glasses") return ui_glasses

		if("acti") return ui_acti

/datum/hud/proc/hidden_inventory_update()
	if(!mymob) return
	if(ishuman(mymob))
		if(special && special.hidden_inventory_update(mymob))
			return

		var/mob/living/carbon/human/H = mymob
		if(inventory_shown && hud_shown)
			if(H.shoes)		H.shoes.screen_loc = get_slot_loc("shoes")
			if(H.gloves)	H.gloves.screen_loc = get_slot_loc("gloves")
			if(H.ears)		H.ears.screen_loc = get_slot_loc("ears")
			if(H.glasses)	H.glasses.screen_loc = get_slot_loc("glasses")
			if(H.w_uniform)	H.w_uniform.screen_loc = get_slot_loc("iclothing")
			if(H.wear_suit)	H.wear_suit.screen_loc = get_slot_loc("oclothing")
			if(H.wear_mask)	H.wear_mask.screen_loc = get_slot_loc("mask")
			if(H.head)		H.head.screen_loc = get_slot_loc("head")
		else
			if(H.shoes)		H.shoes.screen_loc = null
			if(H.gloves)	H.gloves.screen_loc = null
			if(H.ears)		H.ears.screen_loc = null
			if(H.glasses)	H.glasses.screen_loc = null
			if(H.w_uniform)	H.w_uniform.screen_loc = null
			if(H.wear_suit)	H.wear_suit.screen_loc = null
			if(H.wear_mask)	H.wear_mask.screen_loc = null
			if(H.head)		H.head.screen_loc = null

/datum/hud/proc/persistant_inventory_update()
	if(!mymob) return
	if(ishuman(mymob))
		if(special && special.persistant_inventory_update(mymob))
			return

		var/mob/living/carbon/human/H = mymob
		if(hud_shown)
			if(H.s_store)	H.s_store.screen_loc = get_slot_loc("sstore1")
			if(H.wear_id)	H.wear_id.screen_loc = get_slot_loc("id")
			if(H.belt)		H.belt.screen_loc = get_slot_loc("belt")
			if(H.back)		H.back.screen_loc = get_slot_loc("back")
			if(H.l_store)	H.l_store.screen_loc = get_slot_loc("storage1")
			if(H.r_store)	H.r_store.screen_loc = get_slot_loc("storage2")
		else
			if(H.s_store)	H.s_store.screen_loc = null
			if(H.wear_id)	H.wear_id.screen_loc = null
			if(H.belt)		H.belt.screen_loc = null
			if(H.back)		H.back.screen_loc = null
			if(H.l_store)	H.l_store.screen_loc = null
			if(H.r_store)	H.r_store.screen_loc = null


/datum/hud/proc/instantiate()
	if(!ismob(mymob)) return 0
	if(!mymob.client) return 0
	var/ui_style = ui_style2icon(mymob.client.prefs.UI_style)

	if(ishuman(mymob))
		if(get_special_uistyle(mymob.client.prefs.UI_style))
			custom_hud(ui_style,get_special_uistyle(mymob.client.prefs.UI_style))
		else
			human_hud(ui_style) // Pass the player the UI style chosen in preferences

/*		spawn()
			if((RADAR in mymob.augmentations) && mymob.radar_open)
				mymob:start_radar()
			else if(RADAR in mymob.augmentations)
				mymob:place_radar_closed()
*/
	else if(ismonkey(mymob))
		monkey_hud(ui_style)

	else if(isbrain(mymob))
		brain_hud(ui_style)

	else if(islarva(mymob))
		larva_hud()

	else if(isalien(mymob))
		alien_hud()

	else if(isAI(mymob))
		ai_hud()

	else if(isrobot(mymob))
		robot_hud()

//	else if(ishivebot(mymob))
//		hivebot_hud()

//	else if(ishivemainframe(mymob))
//		hive_mainframe_hud()

	else if(isobserver(mymob))
		ghost_hud()

	return
