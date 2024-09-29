class_name AmbientEntity
extends CharacterBody2D

enum Direction {
	RIGHT,
	LEFT,
	DOWN,
	UP,
}

enum AnimationState {
	IDLE,
	WALK,
	ATTACK,
}

var speed : int
var current_direction : Direction
var current_animation_state : AnimationState

func _init(speed: int, current_direction: Direction, current_animation_state: AnimationState) -> void:
	self.speed = speed
	self.current_direction = current_direction
	self.current_animation_state = current_animation_state


func _physics_process(delta) -> void:
	animate()


func move(direction: Direction) -> void:
	match direction:
		Direction.RIGHT:
			velocity.x = speed
			velocity.y = 0
		Direction.LEFT:
			velocity.x = -speed
			velocity.y = 0
		Direction.DOWN:
			velocity.x = 0
			velocity.y = speed
		Direction.UP:
			velocity.x = 0
			velocity.y = -speed
	
	current_direction = direction
	current_animation_state = AnimationState.WALK
	move_and_slide()


func stop() -> void:
	velocity.x = 0
	velocity.y = 0
	
	current_animation_state = AnimationState.IDLE
	move_and_slide()


func animate() -> void:
	match current_animation_state:
		AnimationState.IDLE:
			match current_direction:
				Direction.RIGHT:
					$animation_player.flip_h = false
					$animation_player.play("side_idle")
				Direction.LEFT:
					$animation_player.flip_h = true
					$animation_player.play("side_idle")
				Direction.DOWN:
					$animation_player.play("front_idle")
				Direction.UP:
					$animation_player.play("back_idle")
			
		AnimationState.WALK:
			match current_direction:
				Direction.RIGHT:
					$animation_player.flip_h = false
					$animation_player.play("side_walk")
				Direction.LEFT:
					$animation_player.flip_h = true
					$animation_player.play("side_walk")
				Direction.DOWN:
					$animation_player.play("front_walk")
				Direction.UP:
					$animation_player.play("back_walk")
