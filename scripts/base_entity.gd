class_name BaseEntity
extends AmbientEntity

var health: int
var is_dead: bool = false

func _init(speed: int, current_direction: Direction, current_animation_state: AnimationState, health: int) -> void:
	super(speed, current_direction, current_animation_state)
	self.health = health


func _physics_process(delta) -> void:
	if not is_dead:
		animate()


func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()


func die() -> void:
	health = 0
	is_dead = true
	
	$animation_player.play("death")
	await $animation_player.animation_looped
	queue_free()
