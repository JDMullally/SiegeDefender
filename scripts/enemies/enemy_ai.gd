extends Node
class_name EnemyAI

enum AI_STATE {WALK, ATTACK, IDLE, DIE}
signal change_animation(animation_name : String)
signal stop_moving
signal start_moving
signal attack
signal die
var timer : Timer
var current_state : AI_STATE
var ai_hash


func set_attack_speed(attack_speed : float):
	# f(x) = .45 + (10 - .45) * e ^ (-0.05 * (x - 1)) which creates a range from 10.5 -> .25
	return .25 + (10 - .25) * pow(GameRules.e, (-0.05 * (attack_speed - 1)))

func _init(enemy : Enemy):
	print("bello we are here")
	self.timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = set_attack_speed(enemy.enemy_stats.attack_speed)
	add_child(self.timer)
	change_animation.connect(enemy.set_animation)
	stop_moving.connect(enemy.stop_moving)
	start_moving.connect(enemy.start_moving)
	attack.connect(enemy.attack)
	change_state(AI_STATE.WALK)
	
func change_state(new_state : AI_STATE):
	current_state = new_state
	match current_state:
		AI_STATE.WALK:
			change_animation.emit("walk")
		AI_STATE.ATTACK:
			change_animation.emit("attack")
		AI_STATE.IDLE:
			change_animation.emit("idle")
		AI_STATE.DIE:
			change_animation.emit("die")


func _process(delta: float) -> void:
	decide_state()
	decide_behavior()

func decide_state():
	match current_state:
		AI_STATE.ATTACK:
			if !timer.is_stopped():
				change_state(AI_STATE.IDLE)
		AI_STATE.IDLE:
			if timer.is_stopped():
				change_state(AI_STATE.ATTACK)
	
	
func decide_behavior():
	match current_state:
		AI_STATE.WALK:
			start_moving.emit()
		AI_STATE.ATTACK:
			stop_moving.emit()
			attack.emit()
		AI_STATE.IDLE:
			stop_moving.emit()
		AI_STATE.DIE:
			die.emit()
