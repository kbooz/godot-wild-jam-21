extends Node

var MainInstances = ResourceLoader.MainInstances
var current_level_ref: Node2D = null;
var max_level = 21

onready var player = $Player
onready var playerTrail = $PlayerTrail
onready var transitionAnimator = $Control/ColorRect/Animator

var viewport: Viewport = null
var viewport_rect: Vector2

func _ready():
	VisualServer.set_default_clear_color(Color("#271c22"))
	MainInstances.Player = player
	MainInstances.PlayerTrail = playerTrail
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	viewport = get_viewport()
	viewport_rect = viewport.get_visible_rect().size
	set_level(GameManager.current_level)

func goToLevelSelect():
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		goToLevelSelect()
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN:
		if event is InputEventMouseMotion:
			var can_wrap = false
			var wrap_mouse = event.position
			if(event.position.x < 2):
				wrap_mouse.x = 2
				can_wrap = true
			elif(event.position.x + 2 > viewport_rect.x):
				wrap_mouse.x = viewport_rect.x - 2
				can_wrap = true
			if(event.position.y < 4):
				wrap_mouse.y = 4
				can_wrap = true
			elif(event.position.y + 4 > viewport_rect.y):
				wrap_mouse.y = viewport_rect.y - 4
				can_wrap = true
			if(can_wrap):
				viewport.warp_mouse(wrap_mouse)

func _process(_delta):
#	if(Input.is_action_just_pressed("ui_pause")):
#		if(Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN):
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		else:
#			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if(Input.is_action_just_pressed("ui_right")):
		next_level()
	if Input.is_action_just_pressed("ui_reset"):
		reset_level()

func reset_level():
	MainInstances.Player.to_idle()
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	set_level(GameManager.current_level)

func next_level():
	var next_level = GameManager.current_level + 1;
	MainInstances.Player.to_idle()
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	set_level( next_level if next_level <= max_level else 0 )

func clear_level():
	if(current_level_ref):
		current_level_ref.queue_free()
		remove_child(current_level_ref)

func set_level(level: int, transition = true):
	if(current_level_ref):
		current_level_ref.queue_free()
		remove_child(current_level_ref)
	var new_level = load("res://Scenes/Levels/Level_0%d.tscn" % level)
	var instance = new_level.instance()
	if transition:
		transitionAnimator.play("Fade In")
	add_child_below_node(player, instance)
	current_level_ref = instance
	GameManager.current_level = level
	GameManager.update_completed_levels(level)
	GameManager.holes = instance.holes
	GameManager.reset_record()


func _on_Player_next_level():
	next_level()

func _on_Player_reset_level():
	set_level(GameManager.current_level, false)
