extends Node2D
class_name EnemySpawner

## The enemy library for looking up enemy references
@export var enemy_lib : EnemyLibrary
## The current enemy to spawn. Is an enemy ID value enumerated
## in the enemy library.
@export var enemy : EnemyLibrary.enemy_id

## The current enemy prototype to instantiate
var enemy_prototype : PackedScene

func _ready() -> void:
	# Get the enemy ID specified in editor, pass to enemy dictionary to
	# lookup the resource path, and give resource path to load method to
	# get an enemy prototype to instantiate.
	enemy_prototype = load(enemy_lib.enemy_dictionary[enemy])


## Spawns the spawner's current enemy protoype at its current position and
## adds it to the scene. Also returns the enemy spawned to the caller.
func spawn()->Enemy:
	var new_enemy : Enemy = enemy_prototype.instantiate()
	get_parent().add_child(new_enemy)
	new_enemy.global_position = global_position
	return new_enemy
	
