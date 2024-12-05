extends Control

@onready var upgrade_button: Button = %UpgradeButton
@onready var upgrade_money_ui: Control = %UpgradeMoneyUI
@export var upgrade_type : GameRules.UPGRADE_TYPE
@onready var upgrade_name: Label = %UpgradeType
@onready var number: RichTextLabel = %Number

var tower_layer_reference : TowerLayer
var curr_rank : int
var cost : int

func recieve_information(tower_layer_reference : TowerLayer, rank : int):
	self.tower_layer_reference = tower_layer_reference
	self.curr_rank = rank
	self.upgrade_name.text = "{name_val}".format({"name_val" : get_upgrade_name()})
	self.number.scroll_active = false
	self.number.clear()
	self.number.bbcode_enabled = true
	self.number.append_text("[color={rank_color}] {rank} [/color]".format({"rank": rank, "rank_color": GameRules.get_rank_color(rank)}))
	self.cost = GameRules.calculate_cost(rank)
	self.upgrade_money_ui.set_price(cost)

func _on_upgrade_button_pressed() -> void:
	tower_layer_reference = tower_layer_reference.increase_rank(upgrade_type, cost)
	recieve_information(tower_layer_reference, tower_layer_reference.stat_ranks[upgrade_type])

func get_upgrade_name():
	match upgrade_type:
		GameRules.UPGRADE_TYPE.TIER:
			return "Tier"
		GameRules.UPGRADE_TYPE.BASE_DAMAGE:
			return "Damage"
		GameRules.UPGRADE_TYPE.RANGE:
			return "Range"
		GameRules.UPGRADE_TYPE.ATTACK_SPEED:
			return "Attack Speed"
