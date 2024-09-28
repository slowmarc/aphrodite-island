extends CharacterBody2D

const SPEED = 100.0
var direction = "down"

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		direction = "right"
		play_animation(1)
		
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		direction = "left"
		play_animation(1)

		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		direction = "down"
		play_animation(1)

		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		direction = "up"
		play_animation(1)

		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_animation(0)
		
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_animation(movement):
	var animation = $AnimatedSprite2D2
	
	if direction == "right":
		animation.flip_h = false
		if movement == 0:
			animation.play("side_idle")
		elif movement == 1:
			animation.play("side_walk")
	elif direction == "left":
		animation.flip_h = true
		if movement == 0:
			animation.play("side_idle")
		elif movement == 1:
			animation.play("side_walk")
	elif direction == "down":
		if movement == 0:
			animation.play("front_idle")
		elif movement == 1:
			animation.play("front_walk")
	elif direction == "up":
		if movement == 0:
			animation.play("back_idle")
		elif movement == 1:
			animation.play("back_walk")
