class_name Player
extends Entity

func _init(speed: int = 100, health: int = 20, damage: int = 10, current_direction: Direction = Direction.DOWN) -> void:
	# Call the parent class constructor
	super(speed, health, damage, current_direction)


func _ready() -> void:
	print("Player is ready with speed:", speed, "health:", health, "damage:", damage)


func _physics_process(delta):
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
	
	attack()
	
#
#func _on_hitbox_body_entered(body: Node2D) -> void:
	#if body.has_method("attack_player"):
		##enemy_in_attack_range = true
#
#
#func _on_hitbox_body_exited(body: Node2D) -> void:
	#if body.has_method("attack_player"):
		##enemy_in_attack_range = false
#
#
#func attack_enemy():
	#pass
#
#
#func play_attack_animation():
	#if not Input.is_action_pressed("attack"):
		#return
#
	#is_attack_in_progress = true
	#global.is_player_attacking = true
	#$attack_cooldown.start()
	#match direction:
		#Direction.RIGHT:
			#$animation.flip_h = true
			#$animation.play("side_attack")
		#Direction.LEFT:
			#$animation.flip_h = false
			#$animation.play("side_attack")
		#Direction.DOWN:
			#$animation.play("front_attack")
		#Direction.UP:
			#$animation.play("back_attack")
#
#
#func enemy_attack():
	#if not enemy_attack_cooldown:
		#if enemy_in_attack_range:
			#health -= 5
			#
			#enemy_attack_cooldown = true
			#$damage_cooldown.start()
#
#
#func _on_damage_cooldown_timeout() -> void:
	#enemy_attack_cooldown = false
#
#
#func _on_attack_cooldown_timeout() -> void:
	#$attack_cooldown.stop()
	#global.is_player_attacking = false
	#is_attack_in_progress = false
