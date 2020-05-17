extends Area2D
class_name Hole

signal touched
onready var Animator = $Animator

export(Enums.HOLE_STATE) var state = Enums.HOLE_STATE.NOT_TOUCHED

onready var sprite = $Sprite

func _ready():
	Animator.play("normal")

func fixing():
	state = Enums.HOLE_STATE.FIXING

func touched():
	state = Enums.HOLE_STATE.TOUCHED
	emit_signal("touched", self)
	Animator.play("touched")

func reset():
	state = Enums.HOLE_STATE.NOT_TOUCHED
	Animator.play("normal")
