extends Node2D
class_name DrawCanvas

### ===========================================================================
### References
### ===========================================================================

## The parent node of every line that the user creates
@export var draw_lines : Node2D
## Cursor for showing where the draw point is
@export var draw_cursor : Node2D
## Background to draw on. Shares the dimensions of the ethereal canvas
@export var background : Polygon2D
## The dimensions of the canvas
@export var canvas_dimensions : Vector2i = Vector2i(255, 255)

### ===========================================================================
### Members
### ===========================================================================

## Flag for whether or not drawing is allowed/happening
var is_drawing : bool = false
## Cursor movement speed
var cursor_weight : float = 100.0
## The current line to add points to
var _current_line : Line2D
## Memory of reccently erased lines for redoing
var _recently_deleted : Array

### ===========================================================================
### Helpers
### ===========================================================================

func _ready() -> void:
	# Set background poly dim to canvas dim
	background.polygon = PackedVector2Array([
		Vector2(canvas_dimensions.x/2, -canvas_dimensions.y/2),
		Vector2(canvas_dimensions.x/2, canvas_dimensions.y/2),
		Vector2(-canvas_dimensions.x/2, canvas_dimensions.y/2),
		Vector2(-canvas_dimensions.x/2, -canvas_dimensions.y/2)
	])
	
	
## Function polls for drawing input and populates the canvas accordingly on a
## frame by frame basis.
func poll_drawing(event : InputEvent, delta: float, color : Color = Color.BLACK, width : float = 5.0)->void:
	# Allow cursor movement first
	move_cursor(event, delta)
	
	# If the draw key has been presseed
	if Input.is_action_just_pressed("draw_key"):
		# We are making a new line
		_current_line = Line2D.new()
		_current_line.default_color = color
		_current_line.width = width
		draw_lines.add_child(_current_line)
		# the cursor and the lines share the same parent space
		# as long as neither are moved from their default position
		# which allows this to work
		_current_line.add_point(draw_cursor.position)
	# Otherwise if the key is already pressed in the frame, add another
	# point.
	elif Input.is_action_pressed("draw_key"):
		_current_line.add_point(draw_cursor.position)
		
## 'Removes' a line from the lines node, effectively undoing a stroke
## Literally hides the line child and adds it to a redo cache
func undo_stroke()->void:
	# Get last line child and delete it
	var last_line = draw_lines.get_children()[-1]
	_recently_deleted.append(last_line)
	last_line.hidden = true
	
## Reinstates a recently 'removed' stroke line from redo cache
## Literally removes the last child in the redo cache and unhides it
func redo_stroke()->void:
	var most_recent = _recently_deleted.pop_back()
	most_recent.hidden = false

## Finalizes a drawing
func finish_drawing()->void:
	# Clear the redo cache / remove all lines never used
	for line in _recently_deleted:
		_recently_deleted.erase(line)
		
## Function moves the cursor either to match the mouse location
## or to move based on an input vector from a joystick or keys
func move_cursor(event : InputEvent, delta : float)->void:
	# get the global equivalent of the canvas (this) center 
	var center : Vector2 = global_position
	# if this entire callstack occured due to mouse motion
	if event is InputEventMouseMotion:
		# We ensure that the mouse is currently within the canvas
		if (
			event.position.x <= center.x + canvas_dimensions.x/2 # before right
			and event.position.x >= center.x - canvas_dimensions.x/2 # after left
			and event.position.y <= center.y + canvas_dimensions.y/2 # above bottom
			and event.position.y >= center.y - canvas_dimensions.y/2 # below top
		):
			# if so we can simply set the cursor position to the mouse position
			draw_cursor.global_position = event.global_position
	# Otherwise we get the motion vector from a joystick using input events
	else:
		var direction : Vector2 = Input.get_vector("joy_left_l","joy_right_l","joy_up_l","joy_down_l")
		var new_position = draw_cursor.global_position + (direction * delta * cursor_weight)
		# Ensure the new position is within the canvas
		if (
			new_position.x <= center.x + canvas_dimensions.x/2 # before right
			and new_position.x >= center.x - canvas_dimensions.x/2 # after left
			and new_position.y <= center.y + canvas_dimensions.y/2 # above bottom
			and new_position.y >= center.y - canvas_dimensions.y/2 # below top
		):
			# allow change
			draw_cursor.global_position = new_position
