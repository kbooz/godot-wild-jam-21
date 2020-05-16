extends Control

onready var transitionLayer = $TransitionLayer
onready var transitionAnimator = $TransitionLayer/ColorRect/Animator

func _ready():
	Music.list_play()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Events.emit_signal("add_screenshake", 0.2, 0.1)

func _on_TextureButton_pressed():
	SoundFX.play("Win")
	transitionLayer.layer = 2
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_MusicButton_toggled(button_pressed):
	if(button_pressed):
		Music.list_stop()
	else:
		Music.list_play()
