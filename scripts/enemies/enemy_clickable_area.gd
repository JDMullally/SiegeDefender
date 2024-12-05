extends ClickableArea2D
class_name EnemyClickableArea2D

func _init(collision_shape : CollisionShape2D) -> void:
	super._init(collision_shape)

func do_clickable_thing():
	var enemy : Enemy = self.get_parent()
	GameRules.kill_enemy.emit(enemy)
