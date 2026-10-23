extends Mob
class_name Player

"""
Player-specific mob class extension.

Most driver functions should be overloaded to query input from the user.
"""

### ============================================================================
### References
### ============================================================================

### ============================================================================
### Members
### ============================================================================

### ============================================================================
### Core Functions
### ============================================================================

func _ready()->void:
	pass



func _update(delta: float)->void:
	# Query for movement update
	update_move(delta)
	
	# Query for shooting input
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

func update_move(delta : float)->void:
	var input_vec : Vector2 = Input.get_vector("input_dir_left", "input_dir_right", "input_dir_up", "input_dir_down")
	# If there is movement input
	if input_vec != Vector2.ZERO:
		# linear interpolate the velocity toward the max speed by the acceleration
		velocity = lerp(velocity, input_vec * MAX_SPEED, ACCELERATION * delta)
	# Otherwise
	else:
		# linear interpolate the velocity toward 0 speed by the friction
		velocity = lerp(velocity, Vector2.ZERO, FRICTION * delta)
	# Use the built-in godot movement function for character body 2ds 
	move_and_slide()



func shoot()->void:
	#var projectile_prototype = projectile_prototypes["VineRound"]
	var projectile_prototype = ProjectileLibrary.vine_projectile
	var new_projectile : Projectile = projectile_prototype.instantiate()
	
	# Player currently only shoots up
	var aim_direction : Vector2 = Vector2(0,-1)
	
	# Set the new projectile's movement direction
	new_projectile.set_movement_data(aim_direction)
	# Add the new projectile to the parent space
	get_parent().add_child(new_projectile)
	# Start the projectile's global position at the shooting mob
	new_projectile.global_position = global_position
	# Play its fire sound
	new_projectile.play_fire_sound()
