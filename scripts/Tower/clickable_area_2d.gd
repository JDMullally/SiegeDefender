extends Area2D
class_name ClickableArea2D

var info_dict : Dictionary = {}

func _init(collision : CollisionShape2D):
	self.add_child(collision)
	set_pickable(true)

func update_clickable_area_dict(new_dict : Dictionary):
	self.info_dict = new_dict
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print(info_dict)
		GameRules.send_tower_info_to_ui.emit(info_dict)
