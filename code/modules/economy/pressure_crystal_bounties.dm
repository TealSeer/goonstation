#define CRYSTAL_BOUNTY_STATUS_INCOMPLETE "incomplete"
#define CRYSTAL_BOUNTY_STATUS_ACCEPTABLE "acceptable"
#define CRYSTAL_BOUNTY_STATUS_DECENT "decent"
#define CRYSTAL_BOUNTY_STATUS_IDEAL "ideal"
/// The full explosion-power-to-credits conversion formula. Also used in smallprogs.dm
#define PRESSURE_CRYSTAL_VALUATION(power) (power >= 310 ? (power ** 1.1 * 100) : (power ** 1.1 * 34))

/datum/pressure_crystal_bounty
	var/status = CRYSTAL_BOUNTY_STATUS_INCOMPLETE
	var/target_pressure = 0
	var/sold_value = -1

	New(target_pressure)
		..()
		src.target_pressure = target_pressure

	proc/meets_bounty(crystal_pressure)
		var/distance_from_target_pressure = abs(crystal_pressure - src.target_pressure)
		return distance_from_target_pressure < 10

	proc/calculate_payout(crystal_pressure, selling = FALSE)
		var/value = PRESSURE_CRYSTAL_VALUATION(crystal_pressure)
		var/distance_from_target_pressure = abs(crystal_pressure - src.target_pressure)
		switch(distance_from_target_pressure)
			if(0 to 1)
				value = round(value * 5)
				if(selling)
					src.status = CRYSTAL_BOUNTY_STATUS_IDEAL
					src.sold_value = value
			if(1 to 5)
				value = round(value * 3)
				if(selling)
					src.status = CRYSTAL_BOUNTY_STATUS_DECENT
					src.sold_value = value
			if(5 to 10)
				value = round(value * 2)
				if(selling)
					src.status = CRYSTAL_BOUNTY_STATUS_ACCEPTABLE
					src.sold_value = value
		return value
