extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
var spawned_enemies : Array = []
const MUSHROOM_SPRITE_FRAMES = preload("res://resource/enemy_animations/mushroom.tres")
const ROCK_ELEMENTAL_SPRITE_FRAMES = preload("res://resource/enemy_animations/rock_elemental_sprite_frames.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_enemy():
	if len(spawned_enemies) < 10:
		var num = randi_range(0, 1)
		var sprite_frames : SpriteFrames = MUSHROOM_SPRITE_FRAMES if num > 0 else ROCK_ELEMENTAL_SPRITE_FRAMES
		var flip = num > 0
		var new_enemy = Enemy.new(sprite_frames, EnemyStats.new(), flip, GameRules.ENEMY_TYPE.MELEE)
		spawned_enemies.append(new_enemy)
		add_child(new_enemy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_timer.is_stopped():
		spawn_enemy()
		spawn_timer.start()
