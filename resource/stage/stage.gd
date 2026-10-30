extends Node
class_name Stage

## Entity layer reference
@export var entities : Node2D
## Player characters reference list
@export var players : Array
## Enemy characters reference list
@export var enemies : Array
## Flag for all enemies dead checked
var enemies_dead : bool = false
## Enemy spawner reference list
@export var enemy_spawners : Array

func _ready() -> void:
	# The stage's on ready function adds all player and
	# enemy entities placed in the editor to the running lists
	for ent in entities.get_children():
		list_entity(ent)
			


func _physics_process(delta: float) -> void:
	_update(delta)

	
	
func _update(delta : float)->void:
	# All the stage will currently do on update
	
	if enemies.is_empty() and !enemies_dead:
		print_debug("All enemies eliminated.")
		enemies_dead = true
		
		var enemy : Enemy = (enemy_spawners[0] as EnemySpawner).spawn()
		enemies.append(enemy)
		enemies_dead = false
		


## Function updates the running entity lists with the given entity added.
func list_entity(entity : Node2D)->void:
	if entity is Enemy:
		enemies.append(entity)
	elif entity is Player:
		players.append(entity)
	elif entity is EnemySpawner:
		enemy_spawners.append(entity)
	else:
		printerr("Stage found unrecognized entity in the entities layer \"" + str(entity) + "\"")

## Function updates the running entity lists with the given entity removed.
func unlist_entity(entity : Node2D)->void:
	if entity is Enemy:
		enemies.erase(entity)
	elif entity is Player:
		players.erase(entity)
	elif entity is EnemySpawner:
		enemy_spawners.erase(entity)
	else:
		printerr("Stage given unrecognized entity to unlist \"" + str(entity) + "\"")

	
	
## Signal callback for catching and handling mob deaths when they happen
func on_mob_died(mob : Mob)->void:
	print_debug("Caught mob \"" +  mob.name + "\" died.")
	unlist_entity(mob)
