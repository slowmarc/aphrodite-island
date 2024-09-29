class_name Slime
extends Entity

var target = null

func _init(speed: int = 25, health: int = 10, damage: int = 5, current_direction: Direction = Direction.DOWN) -> void:
	super(speed, health, damage, current_direction)


func _physics_process(delta):
	follow_target(delta)

func follow_target(delta) -> void:
	if target:
		var x_distance = target.position.x - position.x
		var y_distance = target.position.y - position.y

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
	else:
		stop()


func _on_detection_area_body_entered(body: Node2D) -> void:
	target = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	target = null


#func _on_hitbox_body_entered(body: Node2D) -> void:
	##if body.has_method("attack_enemy"):
#
#
#func _on_hitbox_body_exited(body: Node2D) -> void:
	##if body.has_method("attack_enemy"):
