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
## Array of all overlapping hurtboxes
var overlappings : Array = []

### ============================================================================
### Helpers
### ============================================================================

## Gets current velocity value
func get_velocity()->Vector2:
	return velocity

func move(delta : float)->void:
	global_position += (velocity * delta)
	
## Returns whether or not the list of overlapping entities is empty
func is_colliding()->bool:
	return !overlappings.is_empty()

## Returns the overlapping entities
func get_colliding()->Array:
	return overlappings



func _on_hitbox_area_entered(area: Area2D) -> void:
	overlappings.append(area)
func _on_hitbox_area_exited(area: Area2D) -> void:
	overlappings.erase(area)
