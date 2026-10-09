extends Mob
class_name Player

### ============================================================================
### References
### ============================================================================

### ============================================================================
### Members
### ============================================================================

@export var MAX_SPEED : float = 500.0

func _physics_process(delta: float) -> void:
	var input_vec : Vector2 = Input.get_vector("input_dir_left", "input_dir_right", "input_dir_up", "input_dir_down")
	if input_vec != Vector2.ZERO:
		velocity = input_vec * MAX_SPEED
	
	else:
		velocity = Vector2(0.0, 0.0)
		
	move_and_slide()
