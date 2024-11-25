extends Node2D

const TOP_TOWER_INCR = 96
const TOWER_INCR = 64
const STARTING_POINT = Vector2(576, GameRules.TOWER_BASE_POSITION)
var layers : Array[TowerLayer] = []
@onready var tower_base: Sprite2D = %TowerBase
@onready var tower_top: Sprite2D = %TowerTop
@onready var tower_hitbox: Area2D = $TowerBase/TowerHitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameRules.buy_tower.connect(purchase_tower)
	GameRules.request_layers.connect(send_ui_layers)
	var tower_type : TowerType = load("res://resource/tower_resources/rock_tower.tres")
	add_layer(tower_type)
	play_fire_animation()
	

func purchase_tower(tower_type : TowerType, cost : int):
	if cost <= GameRules.money:
		add_layer(tower_type)
		GameRules.update_player_money(-cost)
	else:
		GameRules.show_error_message.emit("Not enough money!")

func add_layer(type : TowerType):
	var height : float = len(layers) + 1
	var layer : TowerLayer = TowerLayer.new(type, height)
	self.add_child(layer)
	layers.append(layer)
	send_ui_layers()
	render_layers()

func send_ui_layers():
	GameRules.send_layers_to_ui.emit(layers)


func render_layers():
	tower_base.global_position = STARTING_POINT
	tower_base.show()
	var layer_count : int = 0
	for layer in layers:
		layer_count += 1
		layer.global_position = Vector2(STARTING_POINT.x, STARTING_POINT.y - (layer_count * TOWER_INCR))
		layer.show()
	tower_top.global_position = Vector2(STARTING_POINT.x, STARTING_POINT.y - (layer_count * TOWER_INCR) - TOP_TOWER_INCR)
	tower_top.show()

func play_fire_animation():
	for animated_sprite in tower_top.get_children():
		animated_sprite.play('default')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tower_hitbox_body_entered(body: Node2D) -> void:
	body.change_state(EnemyAI.AI_STATE.ATTACK)
