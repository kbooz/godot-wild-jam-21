extends KinematicBody2D
class_name Player

signal reset_level
signal next_level

export(int) var SPEED = 600
export(int) var MAX_VELOCITY = 11

var MainInstances = ResourceLoader.MainInstances

enum {
	IDLE,
	MOVE,
	FIXING
}

onready var cursorDirection = $MouseAnchor/CursorDirection
onready var tween = $Tween
onready var animator = $AnimationPlayer
onready var nextLevelTimer = $NextLevel

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
	if MainInstances.PlayerTrail.get_last_point() != position:
		MainInstances.PlayerTrail.add_point(position)
	
	if(Input.is_action_just_pressed("ui_mouse_click")):
		velocity = (get_global_mouse_position() - global_position).normalized()
		MainInstances.PlayerTrail.add_point(position)
		state = MOVE;
		
func on_move_state(delta):
	cursorDirection.hide()
	var delta_speed = SPEED * delta
	var collision =  move_and_collide(delta_speed * velocity)
	MainInstances.PlayerTrail.follow_point(position)
	
	if (collision && collision.collider):
		Events.emit_signal("add_screenshake", 0.3, 0.05)
		match collision.collider.type:
			Enums.TILE_TYPE.HARZARD:
				die()
			Enums.TILE_TYPE.STICKY:
				to_idle()
			_:
				animator.play("Hit")
				velocity = velocity.bounce(collision.normal)
				MainInstances.PlayerTrail.add_point(position)
				MainInstances.PlayerTrail.add_point(position)
				

func on_fixing_state(delta):
	var distance = fixing_hole.position - position
	MainInstances.PlayerTrail.follow_point(position)
	
	if(distance.length() < 10):
		move_to_center_of_fixed()
		return;
	
	velocity += distance
	move_and_collide(velocity * delta)

func move_to_center_of_fixed():
	if not tween.is_active():
		tween.interpolate_property(self, "position", null, fixing_hole.position, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func to_idle():
	MainInstances.PlayerTrail.add_point(position);
	state = IDLE
	
func die():
	position = initial_position
	MainInstances.PlayerTrail.clear_points()
	to_idle()
	emit_signal("reset_level")
	
func _on_HoleDetector_area_entered(area: Area2D):
	Events.emit_signal("add_screenshake", 0.3, 0.2)
	state = FIXING
	fixing_hole = area
	fixing_hole.fixing()

func _on_Tween_tween_completed(object, key):
	to_idle()
	if(fixing_hole):
		fixing_hole.touched()
		fixing_hole = null
	if(MainInstances.GameManager.can_pass()):
		nextLevelTimer.start()

func _on_VisibilityNotifier2D_screen_exited():
	die()

func _on_NextLevel_timeout():
	emit_signal("next_level")
