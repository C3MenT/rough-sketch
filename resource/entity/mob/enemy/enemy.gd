extends Mob
class_name Enemy

# No implementation for update functions yet
func _update(delta: float)->void:
	pass
	
func update_move(delta : float)->void:
	pass

## Return the first player currently in the stage's players list
func get_player()->Player:
	if (!stage.players.is_empty()):
		return stage.players[0]
	return null
