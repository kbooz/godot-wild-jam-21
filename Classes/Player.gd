extends KinematicBody2D
class_name Player

signal reset_level
signal next_level

export(int) var SPEED = 800
export(int) var MAX_VELOCITY = 11

var MainInstances = ResourceLoader.MainInstances

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
var fixing_hole = null
var acc = 1;

func _ready():
	MainInstances.Player = self
	pass

func _physics_process(delta):
		# DEBUG
	if(Input.is_action_just_pressed("ui_accept")):
		state = IDLE
		position = initial_position
	match state:
		IDLE:
			on_idle_state()
		MOVE:
			on_move_state(delta)
		FIXING:
			on_fixing_state(delta)

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
	
	var collision =  move_and_collide(delta_speed * velocity)
	
	if (collision):
		velocity = velocity.bounce(collision.normal)

func on_fixing_state(delta):
	var distance = fixing_hole.position - position
	if(distance.length() < 10):
		move_to_center_of_fixed()
		return;
	
	velocity += distance
	accelerate()
	move_and_collide( (velocity ) * delta)

func move_to_center_of_fixed():
	if not tween.is_active():
		tween.interpolate_property(self, "position", null, fixing_hole.position, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func accelerate():
	pass
	#acc += .005
	#var accVelocity = velocity * acc
	#if(accVelocity.length() <= MAX_VELOCITY):
	#	velocity = accVelocity

func to_idle():
	state = IDLE

func _on_HoleDetector_area_entered(area: Area2D):
	state = FIXING
	fixing_hole = area

func _on_Tween_tween_completed(object, key):
	to_idle()
	if(fixing_hole):
		fixing_hole.touched()
		fixing_hole = null
	if(MainInstances.GameManager.can_pass()):
		emit_signal("next_level")

func _on_VisibilityNotifier2D_screen_exited():
	position = initial_position
	to_idle()
	emit_signal("reset_level")
