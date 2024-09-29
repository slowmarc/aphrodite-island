class_name CombatEntity
extends BaseEntity

var damage: int

var enemy: Node2D = null
var can_attack: bool = true
var is_attacking: bool = false
var is_enemy_in_range: bool = false

func _init(speed: int, current_direction: Direction, current_animation_state: AnimationState, health: int, damage: int) -> void:
		super(speed, current_direction, current_animation_state, health)
		self.damage = damage


func move(direction: Direction) -> void:
	if is_attacking:
		return
	
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
	if is_attacking:
		return
	
	velocity.x = 0
	velocity.y = 0
	
	current_animation_state = AnimationState.IDLE
	move_and_slide()

func attack(enemy: BaseEntity = null) -> void:
	if not can_attack:
		return
	
	if enemy:
		enemy.take_damage(damage)
		
	can_attack = false
	is_attacking = true
	$attack_cooldown.start()
	current_animation_state = AnimationState.ATTACK


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
			
		AnimationState.ATTACK:
			match current_direction:
				Direction.RIGHT:
					$animation_player.flip_h = false
					$animation_player.play("side_attack")
				Direction.LEFT:
					$animation_player.flip_h = true
					$animation_player.play("side_attack")
				Direction.DOWN:
					$animation_player.play("front_attack")
				Direction.UP:
					$animation_player.play("back_attack")


func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	is_attacking = false
	$attack_cooldown.stop()
