extends Node2D
class_name TowerLayer

var sprite_texture = preload("res://art/tower/TowerMiddle.png")
var tower_element = load("res://resource/tower_animations/tower_element_sprite_frame.tres")

@export var type: TowerType
var attack_rate: Timer
var sprite: Sprite2D
var attack_range: Area2D
var click_hitbox : Area2D
var animated_sprite : AnimatedSprite2D
var height : int
var stat_ranks : Dictionary = {GameRules.UPGRADE_TYPE.BASE_DAMAGE : 1, GameRules.UPGRADE_TYPE.ATTACK_SPEED : 1, GameRules.UPGRADE_TYPE.RANGE : 1}

func _init(tower_type : TowerType, height : float) -> void:
	self.type = tower_type
	self.height = height
	set_attack_rate()
	set_tower_sprite()
	set_tower_click_hitbox()
	set_attack_range()
	set_tower_element_animation()
	set_init_stat_ranks_with_tier()

func increase_rank(upgrade_type, cost):
	if GameRules.money <= cost:
		GameRules.show_error_message.emit("Can't afford upgrade")
	else:
		GameRules.update_player_money(-cost)
		stat_ranks[upgrade_type] = stat_ranks[upgrade_type] + 1
		recalculate_stats(upgrade_type)
	return self


func recalculate_stats(upgrade_type):
	match upgrade_type:
		GameRules.UPGRADE_TYPE.ATTACK_SPEED:
			change_attack_rate(attack_rate, type)
		GameRules.UPGRADE_TYPE.RANGE:
			set_attack_range()
		_:
			print("nothing to show")

func update_mouse_over_ui_dict():
	var new_dict = {}
	new_dict["tower_name"] = type.name
	new_dict["attack_speed"] = attack_rate.wait_time
	new_dict["range"] = type.range
	new_dict["tier"] = type.tier_type
	new_dict["element"] = type.base_damage_type
	new_dict["tower_type"] = type.tower_type
	
	click_hitbox.update_clickable_area_dict(new_dict)

func set_init_stat_ranks_with_tier():
	var tower_tier = type.tier_type 
	for stat_rank_key in stat_ranks.keys():
		stat_ranks[stat_rank_key] = stat_ranks[stat_rank_key] + calculate_addition_to_stats_per_tier(tower_tier)
		

func calculate_addition_to_stats_per_tier(tower_tier : GameRules.TIER_TYPE) -> int:
	return (pow(5, tower_tier) - 1)

func set_tower_element_animation():
	animated_sprite = AnimatedSprite2D.new()
	animated_sprite.global_position = Vector2(sprite.global_position.x, sprite.global_position.y - 2.5)
	animated_sprite.sprite_frames = tower_element
	animated_sprite.visibility_layer = 1
	animated_sprite.scale = Vector2(0.7, 0.7)
	animated_sprite.speed_scale = 2
	animated_sprite.play(choose_animation(self.type))
	add_child(animated_sprite)


func choose_animation(tower_type : TowerType) -> String:
	var animation_string = ""
	match tower_type.base_damage_type:
		GameRules.DAMAGE_TYPE.FIRE:
			animation_string += "fire"
		GameRules.DAMAGE_TYPE.LIGHTNING:
			animation_string += "lightning"
		GameRules.DAMAGE_TYPE.SLASHING:
			animation_string += "physical"
		GameRules.DAMAGE_TYPE.BLUDGEONING:
			animation_string += "physical"
		GameRules.DAMAGE_TYPE.PIERCING:
			animation_string += "physical"
		GameRules.DAMAGE_TYPE.MAGIC:
			animation_string += "magic"
		GameRules.DAMAGE_TYPE.COLD:
			animation_string += "cold"
		GameRules.DAMAGE_TYPE.HOLY:
			animation_string += "holy"
		GameRules.DAMAGE_TYPE.SHADOW:
			animation_string += "shadow"
		_:
			animation_string = ""
	return animation_string

func set_tower_sprite():
	sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = sprite_texture
	sprite.show()

func set_attack_rate():
	attack_rate = Timer.new()
	change_attack_rate(self.attack_rate, self.type)
	add_child(attack_rate)

func change_attack_rate(attack_rate, tower_type):
	attack_rate.wait_time = .45 + 2.55 /(sqrt(tower_type.attack_speed + stat_ranks[GameRules.UPGRADE_TYPE.ATTACK_SPEED]))
	# print(.45 + 2.55 /(sqrt(tower_type.attack_speed)))
	print(attack_rate.wait_time)

func set_tower_click_hitbox():
	var sprite_vector2d : Vector2 = sprite.get_rect().size
	var shape = RectangleShape2D.new()
	shape.size = sprite_vector2d
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)
	click_hitbox = ClickableArea2D.new(collision)
	add_child(click_hitbox)
	
func set_attack_range():
	if attack_range:
		for children in attack_range.get_children():
			attack_range.remove_child(children)
	else:
		attack_range = Area2D.new()
		attack_range
		add_child(attack_range)
	
	var sprite_vector2d : Vector2 = sprite.get_rect().size
	attack_range.global_position = Vector2(sprite.global_position.x, sprite.global_position.y + (self.height * .5) * 64)
		
	var calculated_range = self.type.range + stat_ranks[GameRules.UPGRADE_TYPE.RANGE]
		
	var shape_vector = Vector2(sprite_vector2d.x + calculated_range * 2, (self.height) * 64 + 64)
	var shape = RectangleShape2D.new()
	shape.size = shape_vector
		
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)
	attack_range.add_child(collision)
