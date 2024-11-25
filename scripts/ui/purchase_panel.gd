extends Panel

@onready var damage_options: OptionButton = %DamageOptions
@onready var attack_type_options: OptionButton = %AttackTypeOptions
@onready var tier_options: OptionButton = %TierOptions
@onready var tier_price: Control = %TierPrice
@onready var tower_type_price: Control = %TowerTypePrice
@onready var damage_type_price: Control = %DamageTypePrice
@onready var purchase_button: Button = $PurchaseButton
@onready var total_price: Control = $PurchaseButton/TotalPrice

func fill_options_menu():
	for damage_type in GameRules.DAMAGE_TYPE.values():
		damage_options.add_item(GameRules.DAMAGE_TYPE.find_key(damage_type).replace("_", " "), damage_type)
	
	for attack_type in GameRules.TOWER_TYPE.values():
		attack_type_options.add_item(GameRules.TOWER_TYPE.find_key(attack_type).replace("_", " "), attack_type)
	
	for tier_type in GameRules.TIER_TYPE.values():
		tier_options.add_item(GameRules.TIER_TYPE.find_key(tier_type).replace("_", " "), tier_type)


func assign_prices():
	tier_price.set_price(GameRules.get_tier_type_price(tier_options.selected))
	damage_type_price.set_price(GameRules.get_damage_type_price(damage_options.selected))
	tower_type_price.set_price(GameRules.get_tower_type_price(attack_type_options.selected))
	total_price.set_price(tier_price.money * (damage_type_price.money + tower_type_price.money))


func _on_damage_options_item_selected(index: int) -> void:
	assign_prices()

func _on_attack_type_options_item_selected(index: int) -> void:
	assign_prices()

func _on_tier_options_item_selected(index: int) -> void:
	assign_prices()

func _on_purchase_button_pressed() -> void:
	var new_tower : TowerType = GameRules.get_new_tower_type(attack_type_options.selected, damage_options.selected, tier_options.selected)
	GameRules.buy_tower.emit(new_tower, total_price.money)
