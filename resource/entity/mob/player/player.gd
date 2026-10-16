extends Mob
class_name Player

### ============================================================================
### References
### ============================================================================

@onready var projectile_prototype : PackedScene = preload("res://resource/entity/mob/player/player_projectile.tscn")

### ============================================================================
### Members
### ============================================================================

@export var MAX_SPEED : float = 500.0

func _physics_process(delta: float) -> void:
	_update(delta)



func _update(delta: float)->void:
	update_move(delta)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	


## Movement function
func update_move(delta : float)->void:
	var input_vec : Vector2 = Input.get_vector("input_dir_left", "input_dir_right", "input_dir_up", "input_dir_down")
	if input_vec != Vector2.ZERO:
		velocity = input_vec * MAX_SPEED
	
	else:
		velocity = Vector2(0.0, 0.0)
		
	move_and_slide()
	
	

func shoot()->void:
	var new_projectile : Projectile = projectile_prototype.instantiate()
	new_projectile.set_movement_data(Vector2(0,-1), 100, 80)
	get_parent().add_child(new_projectile)
	new_projectile.global_position = global_position
