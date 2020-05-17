extends Control

var transition = preload("res://Scenes/HUD/TransitionLayer.tscn")

var transitionInstance = null

func instance_transition():
	transitionInstance = transition.instance()
	add_child(transitionInstance)

func _ready():
	if not Music.is_playing():
		Music.list_play()
	instance_transition()
	if transitionInstance:
		transitionInstance.fade_in()
		yield(get_tree().create_timer(0.5), "timeout")
		transitionInstance.queue_free()

func _on_TextureButton_pressed():
	instance_transition()
	GameManager.game_started = true
	SoundFX.play("Win", 1, -6)
	if transitionInstance:
		transitionInstance.fade_out()
		yield(get_tree().create_timer(1.0), "timeout")
		transitionInstance.queue_free()
		get_tree().change_scene("res://Scenes/World.tscn")

func _on_LevelsButton_pressed():
	instance_transition()
	SoundFX.play("Win", 1, -6)
	if transitionInstance:
		transitionInstance.fade_out()
		yield(get_tree().create_timer(1.0), "timeout")
		transitionInstance.queue_free()
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")
