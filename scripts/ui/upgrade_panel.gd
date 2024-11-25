extends Panel
const GAME_THEME = preload("res://resource/themes/GameTheme.tres")
@onready var v_box_container: VBoxContainer = %VBoxContainer

var layers_reference : Array[TowerLayer]

@onready var tower_specific_upgrade_panel: Panel = %TowerSpecificUpgradePanel
@onready var upgrade_panel_tower_name: Label = %UpgradePanelTowerName
@onready var damage_widget: Control = %DamageWidget
@onready var attack_speed_widget: Control = %AttackSpeedWidget
@onready var range_widget: Control = %RangeWidget
@onready var tier_widget: Control = %TierWidget

func _ready() -> void:
	GameRules.send_layers_to_ui.connect(save_layer_references)
	GameRules.update_upgrade_panel.connect(show_tower_specific_upgrade_panel)
	hide_tower_specific_upgrade_panel()
	
func save_layer_references(layers : Array[TowerLayer]):
	layers_reference = layers
	update_ui(layers_reference)

func show_tower_specific_upgrade_panel(layer : TowerLayer):
	tower_specific_upgrade_panel.show()
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	var tower_layer_stat_ranks = layer.stat_ranks
	upgrade_panel_tower_name.text = layer.type.name
	
	damage_widget.recieve_information(layer, tower_layer_stat_ranks[GameRules.UPGRADE_TYPE.BASE_DAMAGE])
	attack_speed_widget.recieve_information(layer, tower_layer_stat_ranks[GameRules.UPGRADE_TYPE.ATTACK_SPEED])
	range_widget.recieve_information(layer, tower_layer_stat_ranks[GameRules.UPGRADE_TYPE.RANGE])
	# tier_widget.recieve_information(tower_layer_stat_ranks[GameRules.UPGRADE_TYPE.TIER])

func hide_tower_specific_upgrade_panel():
	tower_specific_upgrade_panel.hide()
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func update_ui(layers_reference: Array[TowerLayer]):
	# wipe the v_box clean
	for child in v_box_container.get_children():
		child.queue_free()
	
	for i in len(layers_reference):
		var tower_layer = layers_reference[i]
		var tower_layer_name = "({tower_num}) {name}".format({"name": tower_layer.type.name, "tower_num": i + 1})
		var button = TowerLayerRefButton.new(GAME_THEME, tower_layer_name, tower_layer)
		v_box_container.add_child(button)


func _on_close_panel_pressed() -> void:
	hide_tower_specific_upgrade_panel()
