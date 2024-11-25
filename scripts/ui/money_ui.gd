extends Control

@onready var money_ui_label: Label = %MoneyUILabel
@export var money_label_type : GameRules.MONEY_LABEL_TYPE
@onready var money : int = 0

var money_suffix_map : Dictionary = {
	"Qi" : 1000000000000000000,
	"Q" : 1000000000000000,
	"T" : 1000000000000,
	"B" : 1000000000,
	"M" : 1000000,
	"K": 1000,
}

func _ready() -> void:
	GameRules.update_coin_ui.connect(update_coins)

func update_coins(new_coin_amount : int, label_type : GameRules.MONEY_LABEL_TYPE):
	if money_label_type == label_type:
		set_price(new_coin_amount)

func set_price(given_money : int):
	money = given_money
	money_ui_label.text = add_suffix_to_money(money)

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func add_suffix_to_money(money: int)-> String:
	for key in money_suffix_map.keys():
		if money % money_suffix_map[key] != money:
			return str(round_to_dec(float(money) / money_suffix_map[key], 2)) + key
	return str(money)
