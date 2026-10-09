extends Control
class_name UserDrawing

"""
User Drawing object is a simple input listening class that creates
a line2D for each unique color used and adds vectors based upon the mouse
position as long as the mouse position is within the canvas.

As a result, while this is on screen, it will:
- Provide a UI of 3 options
-- (choose color, start drawing, and finish)


"""

### ===========================================================================
### References
### ===========================================================================

## Entire canvas component for drawing on
@export var draw_canvas : DrawCanvas

### ===========================================================================
### Members
### ===========================================================================


# Using Input function to poll input only when there is input
# event goes unused
func _input(event: InputEvent) -> void:
	pass
