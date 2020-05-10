extends Node

var current_level_ref: Node2D = null;
var current_level: int = 0;
var max_level = 2
var holes: Array;

func _ready():
	set_level(current_level)

func _process(_delta):
	if(Input.is_action_just_pressed("ui_right")):
		var next_level = current_level + 1;
		set_level( next_level if next_level <= max_level else 0 )

func set_level(level: int):
	if(current_level_ref):
		current_level_ref.queue_free()
	
	var new_level = load("res://Scenes/Levels/Level_0%d.tscn" % level)
	var instance = new_level.instance()
	
	add_child(instance)
	current_level_ref = instance
	current_level = level
	holes = instance.holes
	print(holes.size())
