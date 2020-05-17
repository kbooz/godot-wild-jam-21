extends CanvasLayer

onready var animator = $ColorRect/Animator


func fade_in():
	animator.play("Fade In")

func fade_out():
	animator.play("Fade Out")
