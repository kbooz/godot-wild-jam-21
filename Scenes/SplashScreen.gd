extends Control

var transition = preload("res://Scenes/HUD/TransitionLayer.tscn")

var transitionInstance = null

onready var timer = $Timer

func instance_transition():
	transitionInstance = transition.instance()
	add_child(transitionInstance)

# Called when the node enters the scene tree for the first time.
func _ready():
	instance_transition()
	timer.start()

func _on_Timer_timeout():
	if transitionInstance:
		transitionInstance.fade_out()
		yield(get_tree().create_timer(1.0), "timeout")
		transitionInstance.queue_free()
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/HUD/StartScreen.tscn")
		
