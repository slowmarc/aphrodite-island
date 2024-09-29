class_name Player
extends CombatEntity

func _init(speed: int = 100, current_direction: Direction = Direction.DOWN, current_animation_state: AnimationState = AnimationState.IDLE, health: int = 100, damage: int = 10) -> void:
		super(speed, current_direction, current_animation_state, health, damage)


func _physics_process(delta):
	if not is_dead:
		animate()
	
		handle_movement_input()
		handle_attack_input()


func handle_movement_input() -> void:
	if Input.is_action_pressed("ui_right"):
		move(Direction.RIGHT)
	elif Input.is_action_pressed("ui_left"):
		move(Direction.LEFT)
	elif Input.is_action_pressed("ui_down"):
		move(Direction.DOWN)
	elif Input.is_action_pressed("ui_up"):
		move(Direction.UP)
	else:
		stop()


func handle_attack_input() -> void:
	if not Input.is_action_pressed("attack") or not can_attack:
		return
	
	attack(enemy)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is HostileEntity:
		enemy = body
		is_enemy_in_range = true


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is HostileEntity:
		enemy = null
		is_enemy_in_range = false
