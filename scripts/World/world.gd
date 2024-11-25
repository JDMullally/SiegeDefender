extends Node2D
class_name World

@onready var game_camera: Camera2D = %GameCamera

func _ready() -> void:
	if game_camera:
		print("hello!")

func _process(delta: float) -> void:
	pass
