extends Control

onready var transitionLayer = $TransitionLayer
onready var transitionAnimator = $TransitionLayer/ColorRect/Animator
onready var canvasLayer = $CanvasLayer

func _ready():
	transitionAnimator.play("Fade In")
	yield(get_tree().create_timer(0.5), "timeout")
	transitionLayer.scale = Vector2(0, 0)
	if not Music.is_playing():
		Music.list_play()

func _on_TextureButton_pressed():
	GameManager.game_started = true
	SoundFX.play("Win", 1, -6)
	transitionLayer.scale = Vector2(1, 1)
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_LevelsButton_pressed():
	SoundFX.play("Win", 1, -6)
	transitionLayer.scale = Vector2(1, 1)
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")
