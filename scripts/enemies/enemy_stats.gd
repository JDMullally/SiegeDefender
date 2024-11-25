extends Resource
class_name EnemyStats

enum SIZE {SMALL, MEDIUM, LARGE, GIANT, GARGANTUAN}
@export var hitpoints : int
@export var damage : int
@export var attack_speed : float
@export var resistances : Resistances
@export var size : SIZE

func _init():
	self.resistances = Resistances.new()
	self.damage = 5
	self.attack_speed = 1.0
	self.hitpoints = 10
	var size_val = randi_range(0, 4)
	self.size = size_val
