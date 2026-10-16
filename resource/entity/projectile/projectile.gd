extends PhysicsBody2D
class_name Projectile

"""
Base projectile class for projectiles to inherit from.

Projectiles have no hurtbox as mob entities are intended to listen for them and
not the other way around.
"""

### ============================================================================
### Members
### ============================================================================

## Current velocity vector
var velocity : Vector2 = Vector2.ZERO
## Current acceleration
var acceleration : float = 0.0
## Current max speed
var maxSpeed : float = 0.0
## Current direction to move in
var direction : Vector2 = Vector2.ZERO

### ============================================================================
### Core Drivers
### ============================================================================


func _physics_process(delta: float) -> void:
	_update(delta)

## Core projectile update function
func _update(delta : float)->void:
	_update_move(delta)

### ============================================================================
### Helpers
### ============================================================================

## Gets current velocity value
func get_velocity()->Vector2:
	return velocity

## Update position based on velocity
func _update_move(delta : float)->void:
	if maxSpeed <= 0:
		printerr("Max speed is less than or equal 0")
		
	velocity = velocity.slerp(direction * maxSpeed, acceleration * delta)
	global_position += (velocity * delta)
	
## Give the projectile a direction on the unit circle
func set_movement_data(dir : Vector2, max_speed : float, accel : float)->void:
	maxSpeed = max_speed
	direction = dir
	acceleration = accel
	
