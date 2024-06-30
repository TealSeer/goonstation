ABSTRACT_TYPE(/obj/mapping_helper/airlock)
/obj/mapping_helper/airlock
	name = "airlock helper parent"
	icon = 'icons/map-editing/airlocks.dmi'
	var/bolt = FALSE
	var/weld = FALSE

	setup()
		for (var/obj/machinery/door/airlock/D in src.loc)
			if (src.bolt)
				D.locked = TRUE
			if (src.weld)
				D.welded = TRUE
			D.UpdateIcon()

/obj/mapping_helper/airlock/bolter
	name = "airlock bolter"
	icon_state = "bolted"
	bolt = TRUE

/obj/mapping_helper/airlock/welder
	name = "airlock welder"
	icon_state = "welded"
	weld = TRUE

/* How to Use:
For standard airlocks which are just a single tile in width, you use these ones.
This links them together by their cycle_id.
If you have a double door setup, set both doors in the same direction to have the same entrance_id.

For instance, you have 2 doors facing space and 2 facing inward, with an air lock between.
All four have the same cycle_id. The space facing ones have the same enter_id, and the interior ones have a different ones (that matches)
e.g. "Inside" or just "1" can work as ids. It's based on string matching.

This way, opening one of the double doors on the space side won't close the other space door.
But opening an interior door will still close both space doors.

It's different to tg's direction based one, but these can have 3 way intersections and 90 degree airlocks,
so I feel they're better and more versatile, even if they're harder to set up.. ~Tyrant
*/
/obj/mapping_helper/airlock/cycler
	name = "airlock cycler linkage"
	icon_state = "cycle"
	// for var editing:
	var/cycle_id = ""	//! The ID of the cycling airlock. All airlocks connected should have the same ID
	var/enter_id = ""	//! Used within a network for things like double doors.

	setup()
		if (!src.cycle_id)
			CRASH("[src] has no cycle ID set. Coords: [src.x], [src.y], [src.z]")
		for (var/obj/machinery/door/airlock/D in src.loc)
			D.cycle_id = src.cycle_id
			D.cycle_enter_id = src.enter_id
			D.attempt_cycle_link()
