extends Node

var MainInstances = ResourceLoader.MainInstances
var current_level_ref: Node2D = null;
var current_level: int = 7;
var max_level = 7

onready var playerTrail = $PlayerTrail

func _ready():
	Music.list_play()
	VisualServer.set_default_clear_color(Color("#271c22"))
	MainInstances.PlayerTrail = playerTrail
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_level(current_level)

func _process(_delta):
	if(Input.is_action_just_pressed("ui_pause")):
		if(Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			
	if(Input.is_action_just_pressed("ui_right")):
		next_level()

func next_level():
	var next_level = current_level + 1;
	MainInstances.Player.to_idle()
	set_level( next_level if next_level <= max_level else 0 )

func set_level(level: int):
	if(current_level_ref):
		current_level_ref.queue_free()
		remove_child(current_level_ref)
	var new_level = load("res://Scenes/Levels/Level_0%d.tscn" % level)
	var instance = new_level.instance()
	add_child(instance)
	current_level_ref = instance
	current_level = level
	MainInstances.GameManager.holes = instance.holes

func _on_Player_next_level():
	next_level()

func _on_Player_reset_level():
	MainInstances.GameManager.reset_holes()
