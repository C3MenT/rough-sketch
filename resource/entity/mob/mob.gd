extends CharacterBody2D
class_name Mob

"""
Base Mob Class
"""

### ============================================================================
### References
### ============================================================================

## Prototypes of Projectiles the Mob can use
@export var projectile_prototypes : Dictionary

### ============================================================================
### Members
### ============================================================================

## Max eventual locomotion speed obtainable by movement input.
@export var MAX_SPEED : float = 0.0
## The rate at which the current locomotion speed increases per frame.
@export var ACCELERATION : float = 0.0
## The rate at which current locomotion speed decreases with lack of movement.
@export var FRICTION : float = 0.0

### ============================================================================
### Core Functions
### ============================================================================

# Basic physics process implementation just calls the main update driver
func _physics_process(delta: float) -> void:
	_update(delta)


## Core update driver. Should be overloaded by each implementation
func _update(delta: float)->void:
	printerr("In " + str(self) + ": Update function not implemented.")

## Locomotion movement update function. Should be overloaded by each immplementation
func update_move(delta : float)->void:
	printerr("In " + str(self) + ": Movement update function not implemented.")

## Generic shoot callback for shooting mobs. Should be overloaded.
func shoot()->void:
	push_warning("In " + str(self) + ": Shooting function not implemented.")
