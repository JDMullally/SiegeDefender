extends Node

var money_suffix_map : Dictionary = {
	"Qi" : 1000000000000000000,
	"Q" : 1000000000000000,
	"T" : 1000000000000,
	"B" : 1000000000,
	"M" : 1000000,
	"K": 1000,
}

func scale_to_value(x: float, start: float, end: float, rate: float = 0.01) -> float:
	if start <= end:
		print("start must be greater than end for this scaling function.")
		return start
	if x < 0:
		print("x must be greater than or equal to 0.")
		return start
	if rate <= 0:
		print("rate must be greater than 0.")
		return start
	return end - (end - start) * exp(-rate * x)

func luck_scale(initial_value : float, luck_score : int) -> float:
	return scale_to_value(luck_score, initial_value, 80)

func projectile_attack_speed_scale(attack_speed : int) -> float:
	return scale_to_value(attack_speed, 3.0, .25)

func scale_ground_area_attack_speed(attack_speed : int) -> float:
	return scale_to_value(attack_speed, 4.0, .1)

func scale_constant_attack_speed(attack_speed : int) -> float:
	return scale_to_value(attack_speed, 1.0, .1)
	
func scale_beam_attack_speed(attack_speed : int) -> float:
	return scale_to_value(attack_speed, 2.0, .1)

func shield_recharge_speed(recharge_speed : int) -> float:
	return scale_to_value(recharge_speed, 10.0, 1.0)
