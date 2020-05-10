extends Area2D
class_name Hole

signal touched

export(bool) var is_touched = false

onready var sprite = $Sprite

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(is_touched):
		sprite.modulate = Color.darkblue

func touched():
	is_touched = true
	emit_signal("touched", self)
