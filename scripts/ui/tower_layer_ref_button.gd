extends Button
class_name TowerLayerRefButton

var tower_layer_reference : TowerLayer

func _init(game_theme : Theme, display_text : String, tower_layer_reference: TowerLayer) -> void:
	self.theme = game_theme
	self.text = display_text
	self.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
	self.tower_layer_reference = tower_layer_reference
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	print("bello")
	GameRules.update_upgrade_panel.emit(tower_layer_reference)
	
