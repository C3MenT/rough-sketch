extends RigidBody2D
class_name Projectile

"""
Base projectile class for projectiles to inherit from.

Projectiles have no hurtbox as mob entities are intended to listen for them and
not the other way around.
"""

### ============================================================================
### References
### ============================================================================

## The stats carrier of the projectile
@export var stats : ProjectileBaseStats
## The audio stream player 2d
@export var soundPlayer : AudioStreamPlayer2D

### ============================================================================
### Members
### ============================================================================

#### Current Physics Variables (not stats)

## Current velocity vector
var velocity : Vector2 = Vector2.ZERO
## Current direction to move in
var direction : Vector2 = Vector2.ZERO
## Speed multiplier for shooting entities that change the speed.
var speedMult : float = 1.0
## Acceleration multiplier for shooting entities that change the acceleration.
var accelMult : float = 1.0 

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



## Update position based on velocity
func _update_move(delta : float)->void:
	var maxSpeed : float = stats.max_speed
	var acceleration : float = stats.acceleration
		
	velocity = velocity.lerp(direction * maxSpeed * speedMult, acceleration * delta * accelMult)
	global_position += (velocity * delta)
	
	
	
## Give the projectile a direction on the unit circle and any mob-specific multipliers
func set_movement_data(dir : Vector2, speed_mult : float = 1.0, accel_mult : float = 1.0)->void:
	direction = dir
	speedMult = speed_mult
	accelMult = accel_mult


## Plays the sound in the projectile's audio player or optionally a given
## alternate audio stream
func play_fire_sound(alternate_stream : AudioStream = null)->void:
	var og_stream : AudioStream = soundPlayer.stream
	if alternate_stream:
		soundPlayer.stream = alternate_stream
	soundPlayer.play()
	soundPlayer.stream = og_stream
	

### ============================================================================
### Signal Callbacks
### ============================================================================


## On detect collision with things in the mask layers
## Ensure that the signal is linked to this script,
## the contact_monitor flag is true, and
## max_contacts is at least 1
func _on_body_entered(body: Node) -> void:
	#print_debug("Collision Detected")
	if body is StaticBody2D:
		# if a "world" collider is hit
		if body.collision_layer == 1: 
			queue_free() # delete self
