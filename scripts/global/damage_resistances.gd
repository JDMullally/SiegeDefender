extends Resource
class_name Resistances

@export var resistance_map = {}

func _init() -> void:
	for damage_type in GameRules.DAMAGE_TYPE:
		resistance_map[damage_type] = 0
