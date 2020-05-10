extends Area2D
class_name Hole

signal touched

export(bool) var is_touched = false

onready var sprite = $Sprite

func _ready():
	pass # Replace with function body.

func touched():
	sprite.modulate = Color.darkblue
	is_touched = true
	emit_signal("touched", self)

func reset():
	sprite.modulate = Color.white
	is_touched = false
