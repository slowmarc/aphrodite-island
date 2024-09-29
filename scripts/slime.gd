class_name Slime
extends HostileEntity

func _init(speed: int = 25, current_direction: Direction = Direction.DOWN, current_animation_state: AnimationState = AnimationState.IDLE, health: int = 50, damage: int = 5) -> void:
		super(speed, current_direction, current_animation_state, health, damage)
