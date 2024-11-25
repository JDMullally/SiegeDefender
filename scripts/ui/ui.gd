extends Control

@onready var purchase_menu: Panel = $PurchasePanel
@onready var show_purchase_menu: Button = %ShowPurchaseMenu
@onready var error_text: RichTextLabel = $ErrorText
@onready var error_timer: Timer = $ErrorTimer
@onready var player_money: Control = %PlayerMoney
@onready var upgrade_panel: Panel = $UpgradePanel

var layers_reference : Array[TowerLayer]
var purchase_menu_activated = false
var upgrade_menu_activated = false
var tower_type : TowerType = load("res://resource/tower_resources/rock_tower.tres")

func save_layer_references(layers : Array[TowerLayer]):
	layers_reference = layers
	upgrade_panel.update_ui(layers_reference)
	
func add_events():
	GameRules.show_error_message.connect(show_error)
	GameRules.send_layers_to_ui.connect(save_layer_references)

func _ready() -> void:
	add_events()
	error_text.bbcode_enabled = true
	show_purchase_menu.text = set_purchase_menu_text()
	purchase_menu.fill_options_menu()
	purchase_menu.hide()
	upgrade_panel.hide()
	player_money.update_coins(GameRules.money, GameRules.MONEY_LABEL_TYPE.PLAYER_MONEY)

func set_purchase_menu_text():
	return "Hide Purchase Menu" if purchase_menu_activated else "Show Purchase Menu"

func _process(delta: float) -> void:
	if error_timer.is_stopped():
		error_text.clear()

func show_error(error_message : String):
	error_text.bbcode_enabled = true
	error_timer.wait_time = clampf(len(error_message) / 5.0, 2.0, 5.0)
	error_timer.start()
	var color_wrapped_text = "[color=RED]" + error_message + "[/color]" + "\n"
	error_text.append_text(color_wrapped_text)

func _on_show_purchase_menu_pressed() -> void:
	if purchase_menu_activated:
		purchase_menu.hide()
		purchase_menu_activated = false
	elif not purchase_menu_activated:
		purchase_menu.assign_prices()
		purchase_menu.show()
		purchase_menu_activated = true
	show_purchase_menu.text = set_purchase_menu_text()


func _on_show_upgrade_panel_pressed() -> void:
	if upgrade_menu_activated:
		upgrade_panel.hide()
		upgrade_menu_activated = false
	elif not upgrade_menu_activated:
		upgrade_menu_activated = true
		GameRules.request_layers.emit()
		upgrade_panel.show()
		upgrade_panel.update_ui(layers_reference)
