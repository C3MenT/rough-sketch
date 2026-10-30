extends CharacterBody2D
class_name Mob

"""
Base Mob Class
"""

### ============================================================================
### References
### ============================================================================

## Mob Sprite
@export var sprite : Sprite2D

## Mob Timer Node
@export var timer : Timer

## Current stage root
@export var stage : Stage

### ============================================================================
### Members
### ============================================================================

## Max eventual locomotion speed obtainable by movement input.
@export var MAX_SPEED : float = 0.0
## The rate at which the current locomotion speed increases per frame.
@export var ACCELERATION : float = 0.0
## The rate at which current locomotion speed decreases with lack of movement.
@export var FRICTION : float = 0.0

## Current Mob Health
@export var health : int = 10

## Emitted by each mob upon their death
signal died

### ============================================================================
### Core Functions
### ============================================================================

# The base ready function handles some mob-independent initializers such as
# searching for references not given in the editor.
func _ready() -> void:
	# Look for stage reference if not given explicitly
	if !stage:
		print_debug("No stage reference, looking for one")
		var check_node : Node = get_parent()
		var depth : int = 0
		var max_depth : int = 10
		
		# while get_parent isn't returning null
		while check_node and depth < max_depth: 
			# If the current node is a stage
			if check_node is Stage:
				# set our reference to it
				stage = check_node
				print_debug("Found Stage")
				# end loop
				break 
			# otherwise check one higher
			check_node = check_node.get_parent()
			depth += 1
	
	if stage:
		if !died.is_connected(stage.on_mob_died):
			died.connect(stage.on_mob_died)



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


## Mob death function meant to be invoked when the Mob "dies."
## By default, it emits a signal notifier and deletes the mob.
func die()->void:
	emit_signal("died", self)
	queue_free()
	
## Mob hurt function meant to be invoked when the Mob takes damagae.
## By default, it scales the sprite down and back 3 times rapidly.
func hurt()->void:
	var og_scale : Vector2 = sprite.scale
	for i in range(3):
		sprite.scale = og_scale * 0.3
		await(get_tree().create_timer(0.1).timeout)
		sprite.scale = og_scale
		await(get_tree().create_timer(0.1).timeout)
	
	
	
### ============================================================================
### Signal Callbacks
### ============================================================================

func _on_timer_timeout() -> void:
	pass # Replace with function body.



func _on_hurtbox_area_entered(area: ProjectileHitbox) -> void:
	# Since we expect the area2d to be a projectile hitbox specifically
	# we get the root projectile node reference from it (since they have
	# those in them).
	var projectile : Projectile = area.root_entity
	print_debug(self.name 
	+ " hit by " 
	+ projectile.name 
	+ " for " 
	+ str(projectile.stats.damage)
	+ " damage")
	
	health -= projectile.stats.damage
	
	if health > 0:
		hurt()
	else:
		die()
