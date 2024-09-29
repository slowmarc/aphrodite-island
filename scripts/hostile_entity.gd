class_name HostileEntity
extends CombatEntity

func _init(speed: int, current_direction: Direction, current_animation_state: AnimationState, health: int, damage: int) -> void:
		super(speed, current_direction, current_animation_state, health, damage)


func _physics_process(delta) -> void:
	if not is_dead:
		animate()
		follow_target()

func follow_target() -> void:
	if enemy:
		var x_distance: float = enemy.position.x - position.x
		var y_distance: float = enemy.position.y - position.y

		if abs(x_distance) > 7.5:
			if x_distance > 0:
				move(Direction.RIGHT)
			else:
				move(Direction.LEFT)
		else:
			if y_distance > 0:
				move(Direction.DOWN)
			else:
				move(Direction.UP)
				
		if is_enemy_in_range:
			attack(enemy)
	else:
		stop()
		


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		enemy = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	enemy = null
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		is_enemy_in_range = true


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Player:
		is_enemy_in_range = false
