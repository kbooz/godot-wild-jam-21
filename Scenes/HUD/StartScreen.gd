extends Control

onready var transitionLayer = $CanvasLayer2
onready var transitionAnimator = $CanvasLayer2/TransitionLayer/ColorRect/Animator

func _ready():
	Music.list_play()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/World.tscn")

func _on_TextureButton_pressed():
	transitionLayer.layer = 2
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://Scenes/World.tscn")
