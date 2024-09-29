class_name Entity
extends CharacterBody2D

signal took_damage(damage)

enum Direction {
	RIGHT,
	LEFT,
	DOWN,
	UP
}

var speed: int
var health: int
var damage: int
var current_direction: Direction

var can_attack = true
var is_attacking = false

func _init(speed: int, health: int, damage: int, current_direction: Direction) -> void:
	self.speed = speed
	self.health = health
	self.damage = damage
	self.current_direction = current_direction


func move(direction: Direction) -> void:
	if is_attacking:
		return
	
	match direction:
		Direction.RIGHT:
			velocity.x = speed
			velocity.y = 0
			
			$animation.flip_h = false
			$animation.play("side_walk")
		Direction.LEFT:
			velocity.x = -speed
			velocity.y = 0
			
			$animation.flip_h = true
			$animation.play("side_walk")
		Direction.DOWN:
			velocity.x = 0
			velocity.y = speed
			
			$animation.play("front_walk")
		Direction.UP:
			velocity.x = 0
			velocity.y = -speed
			
			$animation.play("back_walk")
	
	current_direction = direction
	move_and_slide()


func stop() -> void:
	if is_attacking:
		return
	
	velocity.x = 0
	velocity.y = 0
	
	match current_direction:
		Direction.RIGHT:
			$animation.flip_h = false
			$animation.play("side_idle")
		Direction.LEFT:
			$animation.flip_h = true
			$animation.play("side_idle")
		Direction.DOWN:
			$animation.play("front_idle")
		Direction.UP:
			$animation.play("back_idle")
	
	move_and_slide()


func attack() -> void:
	if not can_attack:
		return
	
	can_attack = false
	is_attacking = true
	$attack_cooldown.start()
	
	match current_direction:
		Direction.RIGHT:
			$animation.flip_h = false
			$animation.play("side_attack")
		Direction.LEFT:
			$animation.flip_h = true
			$animation.play("side_attack")
		Direction.DOWN:
			$animation.play("front_attack")
		Direction.UP:
			$animation.play("back_attack")


func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	is_attacking = false
	$attack_cooldown.stop()
