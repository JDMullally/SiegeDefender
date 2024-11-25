extends CharacterBody2D
class_name Enemy

const BASE_MOVE_SPEED = 10

@export var enemy_collision_shape : CollisionShape2D
@export var enemy_stats : EnemyStats
@export var animated_sprite : AnimatedSprite2D
@export var enemy_ai : EnemyAI
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed : float

func _init(sprite_frames : SpriteFrames, enemy_stats : EnemyStats, flip : bool, enemy_type : GameRules.ENEMY_TYPE):
	self.enemy_stats = enemy_stats
	set_scale_and_speed(enemy_stats.size)
	set_sprite(sprite_frames, flip)
	set_collision_shape()
	set_ai(enemy_type)

func set_ai(enemy_type : GameRules.ENEMY_TYPE):
	self.enemy_ai = EnemyAI.new(self)
	add_child(enemy_ai)

func set_animation(animation_name : String):
	animated_sprite.play(animation_name)

func set_collision_shape():
	self.enemy_collision_shape = CollisionShape2D.new()
	var animation = animated_sprite.animation
	var current_frame = animated_sprite.frame
	var new_collision_shape = RectangleShape2D.new()
	new_collision_shape.size = animated_sprite.sprite_frames.get_frame_texture(animation, current_frame).get_size()
	new_collision_shape.size.x = roundi(new_collision_shape.size.x * .75)
	enemy_collision_shape.shape = new_collision_shape
	add_child(enemy_collision_shape)
	self.set_collision_layer_value(1, false)
	self.set_collision_mask_value(1, false)
	self.set_collision_layer_value(2, false)
	self.set_collision_mask_value(2, true)
	self.set_collision_layer_value(3, true)

func set_sprite(sprite_frames : SpriteFrames, flip : bool):
	self.animated_sprite = AnimatedSprite2D.new()
	animated_sprite.sprite_frames = sprite_frames
	if flip:
		animated_sprite.flip_h = true
	add_child(animated_sprite)

func set_scale_and_speed(size):
	match size:
		EnemyStats.SIZE.SMALL:
			self.scale = Vector2(.5, .5)
		EnemyStats.SIZE.MEDIUM:
			self.scale = Vector2(1,1)
		EnemyStats.SIZE.LARGE:
			self.scale = Vector2(1.5,1.5)
		EnemyStats.SIZE.GIANT:
			self.scale = Vector2(2,2)
		EnemyStats.SIZE.GARGANTUAN:
			self.scale = Vector2(2.5, 2.5)
	start_moving()

func stop_moving():
	speed = 0

func attack():
	pass

func die():
	queue_free()

func start_moving():
	self.speed = calculate_speed_with_size()

func calculate_speed_with_size():
	match enemy_stats.size:
		EnemyStats.SIZE.SMALL:
			return BASE_MOVE_SPEED * randf_range(1.5, 2.0)
		EnemyStats.SIZE.MEDIUM:
			return BASE_MOVE_SPEED
		EnemyStats.SIZE.LARGE:
			return BASE_MOVE_SPEED * randf_range(.8, .9)
		EnemyStats.SIZE.GIANT:
			return BASE_MOVE_SPEED * randf_range(.6, .7)
		EnemyStats.SIZE.GARGANTUAN:
			return BASE_MOVE_SPEED * randf_range(.4, .5)
			

func _process(delta: float):
	pass

func change_state(state : EnemyAI.AI_STATE):
	enemy_ai.change_state(state)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity
		
	velocity.x = speed
	move_and_slide()
