extends KinematicBody2D
class_name Player

signal reset_level
signal next_level
signal launched
signal bounced

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
const COLLISION_EFFECT = preload("res://Classes/CollisionParticle.tscn")

var initial_position = Vector2.ZERO

var state = IDLE
var velocity = Vector2.ZERO
var fixing_hole = null
var acc = 1;
var bounce_combo = 0;

func _ready():
	MainInstances.Player = self
	pass

func initialize():
	to_idle()
	position = initial_position

func _physics_process(delta):
	# DEBUG
	if(Input.is_action_just_pressed("ui_accept")):
		emit_signal("reset_level")
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
		animator.play("Flash")
		SoundFX.play("Launch", 1, 6)
		velocity = (get_global_mouse_position() - global_position).normalized()
		MainInstances.PlayerTrail.add_point(position)
		emit_signal("launched")
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
				SoundFX.play("Glue", 3)
				emit_signal("bounced")
				instance_collision_particle(collision)
				to_idle()
			_:
				animator.play("Flash")
				play_bounce()
				instance_collision_particle(collision)
				velocity = velocity.bounce(collision.normal)
				emit_signal("bounced")
				MainInstances.PlayerTrail.add_point(position)
				MainInstances.PlayerTrail.add_point(position)
				

func instance_collision_particle(collision: KinematicCollision2D):
	var scene = get_tree().current_scene
	var instance = COLLISION_EFFECT.instance()
	scene.add_child(instance)
	instance.position = position
	instance.rotation = collision.normal.angle()

func play_bounce():
	SoundFX.play("Bounce" + str(bounce_combo), 1, 6)
	bounce_combo += 1
	bounce_combo = clamp(bounce_combo, 0, 18)

func on_fixing_state(delta):
	var distance = fixing_hole.position - position
	MainInstances.PlayerTrail.follow_point(position)
	
	if(distance.length() < 10):
		move_to_center_of_fixed()
		return;
	
	velocity += distance
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)

func move_to_center_of_fixed():
	if not tween.is_active():
		tween.interpolate_property(self, "position", null, fixing_hole.position, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func to_idle():
	bounce_combo = 0
	MainInstances.PlayerTrail.add_point(position);
	state = IDLE
	
func die():
	SoundFX.play("Die", 1, 3)
	emit_signal("reset_level")
	
func _on_HoleDetector_area_entered(area: Area2D):
	Events.emit_signal("add_screenshake", 0.3, 0.2)
	state = FIXING
	fixing_hole = area
	fixing_hole.fixing()

func _on_Tween_tween_completed(_object, _key):
	to_idle()
	if fixing_hole:
		SoundFX.play("Attach")
		fixing_hole.touched()
		fixing_hole = null
	if GameManager.can_pass():
		GameManager.update_completed_levels(null, true)
		SoundFX.play("Win", 1, -6)
		nextLevelTimer.start()

func _on_VisibilityNotifier2D_screen_exited():
	if state != IDLE:
		die()

func _on_NextLevel_timeout():
	emit_signal("next_level")
