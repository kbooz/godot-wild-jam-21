extends KinematicBody2D

export(int) var SPEED = 200

enum {
	IDLE,
	MOVE
}

onready var cursorDirection = $MouseAnchor/CursorDirection

var direction = Vector2.ZERO
var state = IDLE

func _ready():
	pass # Replace with function body.

func _process(delta):
	var delta_speed = SPEED * delta
	
	match state:
		IDLE:
			direction = Vector2.ZERO
			cursorDirection.show()
			
			if(Input.is_action_just_pressed("ui_mouse_click")):
				direction = (get_global_mouse_position() - global_position).normalized()
				state = MOVE;
		
		MOVE:
			cursorDirection.hide()
			
			if(Input.is_action_just_pressed("ui_mouse_click")):
				state = IDLE
		
	position += delta_speed * direction
	
