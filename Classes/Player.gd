extends KinematicBody2D

export(int) var SPEED = 1000
export(int) var MAX_VELOCITY = 11


enum {
	IDLE,
	MOVE,
	FIXING
}

onready var cursorDirection = $MouseAnchor/CursorDirection
onready var tween = $Tween

var initial_position = Vector2.ZERO

var state = IDLE
var velocity = Vector2.ZERO
var fixing_position = Vector2.ZERO
var fixing_transition = 0
var acc = 1;

func _ready():
	initial_position = position
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		IDLE:
			on_idle_state()
		MOVE:
			on_move_state(delta)
		FIXING:
			on_fixing_state(delta)

	# DEBUG
	if(Input.is_action_just_pressed("ui_accept")):
		state = IDLE
		position = initial_position


func on_idle_state():
	velocity = Vector2.ZERO
	acc = 1
	cursorDirection.show()
	
	if(Input.is_action_just_pressed("ui_mouse_click")):
		velocity = (get_global_mouse_position() - global_position).normalized()
		state = MOVE;
		
func on_move_state(delta):
	cursorDirection.hide()
	var delta_speed = SPEED * delta
	accelerate()
	
	var collision =  move_and_collide(delta_speed * velocity)
	if(collision):
		print(collision)

func on_fixing_state(delta):
	var distance = fixing_position - position
	if(distance.length() < 10):
		move_to_center_of_fixed()
		return;
	
	velocity += distance
	accelerate()
	move_and_collide( (velocity ) * delta)

func move_to_center_of_fixed():
	tween.interpolate_property(self, "position", null, fixing_position, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_callback(self, 0.1, "is_fixed")
	tween.start()
		#state = IDLE

func accelerate():
	pass
	#acc += .005
	#var accVelocity = velocity * acc
	#if(accVelocity.length() <= MAX_VELOCITY):
	#	velocity = accVelocity

func is_fixed():
	state = IDLE

func _on_HoleDetector_area_entered(area: Area2D):
	state = FIXING
	fixing_position = area.position
