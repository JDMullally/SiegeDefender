extends Resource
class_name TowerType

#@export var sprite : Sprite2D
@export var name : String
@export var tower_type : GameRules.TOWER_TYPE
@export var base_damage_type : GameRules.DAMAGE_TYPE
@export var base_damage : int # base damage to be modified
@export var attack_speed : float # Attacks per second
@export var range : int # range in meters
@export var tier_type : GameRules.TIER_TYPE
