/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/

/datum/sprite_accessory

	var/icon			// the icon file the accessory is located in
	var/icon_state		// the icon_state of the accessory
	var/preview_state	// a custom preview state for whatever reason

	var/name			// the preview name of the accessory

	// Determines if the accessory will be skipped or included in random hair generations
	var/gender = NEUTER

	// Restrict some styles to specific races
	var/list/species_allowed = list("Human", "Android")

	// Whether or not the accessory can be affected by colouration
	var/do_colouration = 1


/*
////////////////////////////
/  =--------------------=  /
/  == Hair Definitions ==  /
/  =--------------------=  /
////////////////////////////
*/

/datum/sprite_accessory/hair

	icon = 'icons/mob/Human_face.dmi'	  // default icon for all hairs

	bald
		name = "Bald"
		icon_state = "bald"
		gender = MALE
		species_allowed = list("Human","Unathi", "Android")

	short
		name = "Short Hair"	  // try to capatilize the names please~
		icon_state = "hair_a" // you do not need to define _s or _l sub-states, game automatically does this for you
		species_allowed = list("Human","Unathi", "Android")

	cut
		name = "Cut Hair"
		icon_state = "hair_c"
		species_allowed = list("Human", "Android")

	long
		name = "Shoulder-length Hair"
		icon_state = "hair_b"
		species_allowed = list("Human", "Android")

	longalt
		name = "Shoulder-length Hair Alt"
		icon_state = "hair_longfringe"
		species_allowed = list("Human", "Android")

	longish
		name = "Longer Hair"
		icon_state = "hair_b2"
		species_allowed = list("Human", "Android")

	longer
		name = "Long Hair"
		icon_state = "hair_vlong"
		species_allowed = list("Human", "Android")

	longeralt
		name = "Long Hair Alt"
		icon_state = "hair_vlongfringe"
		species_allowed = list("Human", "Android")

	longest
		name = "Very Long Hair"
		icon_state = "hair_longest"
		species_allowed = list("Human", "Android")

	longfringe
		name = "Long Fringe"
		icon_state = "hair_longfringe"
		species_allowed = list("Human", "Android")

	ladylike
		name = "Ladylike"
		icon_state = "hair_test"
		species_allowed = list("Human","Unathi", "Android")

	ladylike2
		name = "Ladylike Alt"
		icon_state = "hair_levb"
		species_allowed = list("Human","Unathi", "Android")

	longestalt
		name = "Longer Fringe"
		icon_state = "hair_vlongfringe"
		species_allowed = list("Human", "Android")

	halfbang
		name = "Half-banged Hair"
		icon_state = "hair_halfbang"
		species_allowed = list("Human", "Android")

	halfbangalt
		name = "Half-banged Hair Alt"
		icon_state = "hair_halfbang_alt"
		species_allowed = list("Human", "Android")

	ponytail1
		name = "Ponytail 1"
		icon_state = "hair_ponytail"
		species_allowed = list("Human", "Android")

	ponytail2
		name = "Ponytail 2"
		icon_state = "hair_pa"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	ponytail3
		name = "Ponytail 3"
		icon_state = "hair_ponytail3"
		species_allowed = list("Human", "Android")

	parted
		name = "Parted"
		icon_state = "hair_parted"
		species_allowed = list("Human", "Android")

	pompadour
		name = "Pompadour"
		icon_state = "hair_pompadour"
		gender = MALE
		species_allowed = list("Human","Unathi", "Android")

	quiff
		name = "Quiff"
		icon_state = "hair_quiff"
		gender = MALE
		species_allowed = list("Human", "Android")

	bedhead
		name = "Bedhead"
		icon_state = "hair_bedhead"
		species_allowed = list("Human", "Android")

	bedhead2
		name = "Bedhead 2"
		icon_state = "hair_bedheadv2"
		species_allowed = list("Human", "Android")

	bedhead3
		name = "Bedhead 3"
		icon_state = "hair_bedheadv3"
		species_allowed = list("Human", "Android")

	beehive
		name = "Beehive"
		icon_state = "hair_beehive"
		gender = FEMALE
		species_allowed = list("Human","Unathi", "Android")

	bobcurl
		name = "Bobcurl"
		icon_state = "hair_bobcurl"
		gender = FEMALE
		species_allowed = list("Human","Unathi", "Android")

	bob
		name = "Bob"
		icon_state = "hair_bobcut"
		gender = FEMALE
		species_allowed = list("Human","Unathi", "Android")

	bowl
		name = "Bowl"
		icon_state = "hair_bowlcut"
		gender = MALE
		species_allowed = list("Human", "Android")

	buzz
		name = "Buzzcut"
		icon_state = "hair_buzzcut"
		gender = MALE
		species_allowed = list("Human","Unathi", "Android")

	crew
		name = "Crewcut"
		icon_state = "hair_crewcut"
		gender = MALE
		species_allowed = list("Human", "Android")

	combover
		name = "Combover"
		icon_state = "hair_combover"
		gender = MALE
		species_allowed = list("Human", "Android")

	devillock
		name = "Devil Lock"
		icon_state = "hair_devilock"
		species_allowed = list("Human", "Android")

	dreadlocks
		name = "Dreadlocks"
		icon_state = "hair_dreads"
		species_allowed = list("Human", "Android")

	curls
		name = "Curls"
		icon_state = "hair_curls"
		species_allowed = list("Human", "Android")

	afro
		name = "Afro"
		icon_state = "hair_afro"
		species_allowed = list("Human", "Android")

	afro2
		name = "Afro 2"
		icon_state = "hair_afro2"
		species_allowed = list("Human", "Android")

	afro_large
		name = "Big Afro"
		icon_state = "hair_bigafro"
		gender = MALE
		species_allowed = list("Human", "Android")

	sargeant
		name = "Flat Top"
		icon_state = "hair_sargeant"
		gender = MALE
		species_allowed = list("Human", "Android")

	emo
		name = "Emo"
		icon_state = "hair_emo"
		species_allowed = list("Human", "Android")

	fag
		name = "Flow Hair"
		icon_state = "hair_f"
		species_allowed = list("Human", "Android")

	feather
		name = "Feather"
		icon_state = "hair_feather"
		species_allowed = list("Human", "Android")

	hitop
		name = "Hitop"
		icon_state = "hair_hitop"
		gender = MALE
		species_allowed = list("Human", "Android")

	mohawk
		name = "Mohawk"
		icon_state = "hair_d"
		species_allowed = list("Human","Unathi")
	jensen
		name = "Adam Jensen Hair"
		icon_state = "hair_jensen"
		gender = MALE
		species_allowed = list("Human", "Android")

	gelled
		name = "Gelled Back"
		icon_state = "hair_gelled"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	spiky
		name = "Spiky"
		icon_state = "hair_spikey"
		species_allowed = list("Human","Unathi", "Android")

	kusangi
		name = "Kusanagi Hair"
		icon_state = "hair_kusanagi"
		species_allowed = list("Human", "Android")

	kusanagialt
		name = "Kusanagi Alternative Hair"
		icon_state = "hair_kusanagialt"
		species_allowed = list("Human", "Android")

	hamasaki
		name = "Hamasaki Hair"
		icon_state = "hair_hamasaki"
		species_allowed = list("Human", "Android")

	kagami
		name = "Pigtails"
		icon_state = "hair_kagami"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	himecut
		name = "Hime Cut"
		icon_state = "hair_himecut"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	braid
		name = "Floorlength Braid"
		icon_state = "hair_braid"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	odango
		name = "Odango"
		icon_state = "hair_odango"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	ombre
		name = "Ombre"
		icon_state = "hair_ombre"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	unitfringe
		name = "Test Fringe"
		icon_state = "test4"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	updo
		name = "Updo"
		icon_state = "hair_updo"
		gender = FEMALE
		species_allowed = list("Human", "Android")

	skinhead
		name = "Skinhead"
		icon_state = "hair_skinhead"
		species_allowed = list("Human", "Android")

	balding
		name = "Balding Hair"
		icon_state = "hair_e"
		gender = MALE // turnoff!
		species_allowed = list("Human", "Android")


	bald
		name = "Bald"
		icon_state = "bald"
		species_allowed = list("Human", "Android")
/*
///////////////////////////////////
/  =---------------------------=  /
/  == Facial Hair Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/facial_hair

	icon = 'icons/mob/Human_face.dmi'
	gender = MALE // barf (unless you're a dorf, dorfs dig chix /w beards :P)

	shaved
		name = "Shaved"
		icon_state = "bald"
		gender = NEUTER
		species_allowed = list("Human","Unathi","Tajaran","Skrell","Vox", "Android")

	watson
		name = "Watson Mustache"
		icon_state = "facial_watson"
		species_allowed = list("Human", "Android")

	hogan
		name = "Hulk Hogan Mustache"
		icon_state = "facial_hogan" //-Neek
		species_allowed = list("Human", "Android")

	vandyke
		name = "Van Dyke Mustache"
		icon_state = "facial_vandyke"
		species_allowed = list("Human", "Android")

	chaplin
		name = "Square Mustache"
		icon_state = "facial_chaplin"
		species_allowed = list("Human", "Android")

	selleck
		name = "Selleck Mustache"
		icon_state = "facial_selleck"
		species_allowed = list("Human", "Android")

	neckbeard
		name = "Neckbeard"
		icon_state = "facial_neckbeard"
		species_allowed = list("Human", "Android")

	fullbeard
		name = "Full Beard"
		icon_state = "facial_fullbeard"
		species_allowed = list("Human", "Android")

	longbeard
		name = "Long Beard"
		icon_state = "facial_longbeard"
		species_allowed = list("Human", "Android")

	vlongbeard
		name = "Very Long Beard"
		icon_state = "facial_wise"
		species_allowed = list("Human", "Android")

	elvis
		name = "Elvis Sideburns"
		icon_state = "facial_elvis"
		species_allowed = list("Human","Unathi", "Android")

	abe
		name = "Abraham Lincoln Beard"
		icon_state = "facial_abe"
		species_allowed = list("Human", "Android")

	chinstrap
		name = "Chinstrap"
		icon_state = "facial_chin"
		species_allowed = list("Human", "Android")

	hip
		name = "Hipster Beard"
		icon_state = "facial_hip"
		species_allowed = list("Human", "Android")

	gt
		name = "Goatee"
		icon_state = "facial_gt"
		species_allowed = list("Human", "Android")

	jensen
		name = "Adam Jensen Beard"
		icon_state = "facial_jensen"
		species_allowed = list("Human", "Android")

	dwarf
		name = "Dwarf Beard"
		icon_state = "facial_dwarf"
		species_allowed = list("Human", "Android")

/*
///////////////////////////////////
/  =---------------------------=  /
/  == Alien Style Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/hair
	una_spines_long
		name = "Long Unathi Spines"
		icon_state = "soghun_longspines"
		species_allowed = list("Unathi")
		do_colouration = 0

	una_spines_short
		name = "Short Unathi Spines"
		icon_state = "soghun_shortspines"
		species_allowed = list("Unathi")
		do_colouration = 0

	una_frills_long
		name = "Long Unathi Frills"
		icon_state = "soghun_longfrills"
		species_allowed = list("Unathi")
		do_colouration = 0

	una_frills_short
		name = "Short Unathi Frills"
		icon_state = "soghun_shortfrill"
		species_allowed = list("Unathi")
		do_colouration = 0

	una_horns
		name = "Unathi Horns"
		icon_state = "soghun_horns"
		species_allowed = list("Unathi")
		do_colouration = 0

	skr_tentacle_m
		name = "Skrell Male Tentacles"
		icon_state = "skrell_hair_m"
		species_allowed = list("Skrell")
		do_colouration = 0
		gender = MALE

	skr_tentacle_f
		name = "Skrell Female Tentacles"
		icon_state = "skrell_hair_f"
		species_allowed = list("Skrell")
		do_colouration = 0
		gender = FEMALE

	skr_gold_m
		name = "Gold plated Skrell Male Tentacles"
		icon_state = "skrell_goldhair_m"
		species_allowed = list("Skrell")
		do_colouration = 0
		gender = MALE

	skr_gold_f
		name = "Gold chained Skrell Female Tentacles"
		icon_state = "skrell_goldhair_f"
		species_allowed = list("Skrell")
		do_colouration = 0
		gender = FEMALE

	skr_clothtentacle_m
		name = "Cloth draped Skrell Male Tentacles"
		icon_state = "skrell_clothhair_m"
		species_allowed = list("Skrell")
		do_colouration = 0
		gender = MALE

	skr_clothtentacle_f
		name = "Cloth draped Skrell Female Tentacles"
		icon_state = "skrell_clothhair_f"
		species_allowed = list("Skrell")
		do_colouration = 0
		gender = FEMALE

	taj_ears
		name = "Tajaran Ears"
		icon_state = "ears_plain"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_clean
		name = "Tajara Clean"
		icon_state = "hair_clean"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_shaggy
		name = "Tajara Shaggy"
		icon_state = "hair_shaggy"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_mohawk
		name = "Tajaran Mohawk"
		icon_state = "hair_mohawk"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_plait
		name = "Tajara Plait"
		icon_state = "hair_plait"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_straight
		name = "Tajara Straight"
		icon_state = "hair_straight"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_long
		name = "Tajara Long"
		icon_state = "hair_long"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_rattail
		name = "Tajara Rat Tail"
		icon_state = "hair_rattail"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_spiky
		name = "Tajara Spiky"
		icon_state = "hair_tajspiky"
		species_allowed = list("Tajaran")
		do_colouration = 0

	taj_ears_messy
		name = "Tajara Messy"
		icon_state = "hair_messy"
		species_allowed = list("Tajaran")
		do_colouration = 0

	vox_quills_short
		name = "Short Vox Quills"
		icon_state = "vox_shortquills"
		species_allowed = list("Vox")
		do_colouration = 0

/datum/sprite_accessory/facial_hair

	taj_sideburns
		name = "Tajara Sideburns"
		icon_state = "facial_mutton"
		species_allowed = list("Tajaran")

	taj_mutton
		name = "Tajara Mutton"
		icon_state = "facial_mutton"
		species_allowed = list("Tajaran")

	taj_pencilstache
		name = "Tajara Pencilstache"
		icon_state = "facial_pencilstache"
		species_allowed = list("Tajaran")

	taj_moustache
		name = "Tajara Moustache"
		icon_state = "facial_moustache"
		species_allowed = list("Tajaran")

	taj_goatee
		name = "Tajara Goatee"
		icon_state = "facial_goatee"
		species_allowed = list("Tajaran")

	taj_smallstache
		name = "Tajara Smallsatche"
		icon_state = "facial_smallstache"
		species_allowed = list("Tajaran")

//skin styles - WIP
//going to have to re-integrate this with surgery
//let the icon_state hold an icon preview for now
/datum/sprite_accessory/skin
	icon = 'icons/mob/human_races/r_human.dmi'

	human
		name = "Default human skin"
		icon_state = "default"
		species_allowed = list("Human")

	human_tatt01
		name = "Tatt01 human skin"
		icon_state = "tatt1"
		species_allowed = list("Human")

	tajaran
		name = "Default tajaran skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_tajaran.dmi'
		species_allowed = list("Tajaran")

	unathi
		name = "Default Unathi skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_lizard.dmi'
		species_allowed = list("Unathi")

	skrell
		name = "Default skrell skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_skrell.dmi'
		species_allowed = list("Skrell")
