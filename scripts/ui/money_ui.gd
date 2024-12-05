extends Control

@onready var money_ui_label: Label = %MoneyUILabel
@export var money_label_type : GameRules.MONEY_LABEL_TYPE
@onready var money : int = 0

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
	for key in Math.money_suffix_map.keys():
		if money % Math.money_suffix_map[key] != money:
			return str(round_to_dec(float(money) / Math.money_suffix_map[key], 2)) + key
	return str(money)
