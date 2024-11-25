extends ParallaxLayer

@export var CLOUD_SPEED = -15
@export var sprite1 : Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.motion_offset.x += CLOUD_SPEED * delta
