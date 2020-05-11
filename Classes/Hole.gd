extends Area2D
class_name Hole

signal touched

export(bool) var is_touched = false

onready var sprite = $Sprite

func touched():
	#sprite.modulate = Color.darkblue
	sprite.texture = load("res://Assets/base_hole_filled.png")
	is_touched = true
	emit_signal("touched", self)

func reset():
	sprite.texture = load("res://Assets/base_hole_empty.png")
	#sprite.modulate = Color.white
	is_touched = false
