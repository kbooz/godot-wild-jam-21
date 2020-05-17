extends Control

onready var transitionLayer = $TransitionLayer
onready var transitionAnimator = $TransitionLayer/ColorRect/Animator
onready var musicButton = $MusicButton
onready var ui = $UI
onready var launchesCounter = $UI/LaunchesCounter
onready var bouncesCounter = $UI/BouncesCounter

var current_hovered = null

func _ready():
	register_buttons()
	var buttons = get_tree().get_nodes_in_group("LevelBtns")
	for button in buttons:
		if not GameManager.completed_levels.has(str(button.level - 1)):
			button.disabled = true
		button.connect("select_level", self, "_on_level_select")
		button.connect("hovered", self, "_on_LevelButton_hovered")
		button.connect("blurred", self, "_on_LevelButton_blurred")
	transitionAnimator.play("Fade In")
	yield(get_tree().create_timer(0.5), "timeout")
	transitionLayer.scale = Vector2(0, 0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func register_buttons():
	musicButton.pressed = !Music.is_playing()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		transitionLayer.scale = Vector2(1, 1)
		transitionAnimator.play("Fade Out")
		yield(get_tree().create_timer(1.0), "timeout")
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/World.tscn")

func _on_level_select():
	transitionLayer.scale = Vector2(1, 1)
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_HomeButtton_pressed():
	SoundFX.play("Win", 1, -6)
	transitionLayer.scale = Vector2(1, 1)
	transitionAnimator.play("Fade Out")
	yield(get_tree().create_timer(1.0), "timeout")
	# warning-ignore:return_value_discarded	
	get_tree().change_scene("res://Scenes/HUD/StartScreen.tscn")

func _on_LevelButton_hovered(level):
	current_hovered = level - 1
	var str_level = str(current_hovered)
	if(!GameManager.records.has(str_level) ||
	(GameManager.records.has(str_level) && !GameManager.records[str_level])):
		ui.hide()
	else:
		var record = GameManager.records[str_level]
		show_record(record.launches, record.bounces)

func show_record(launches, bounces):
	ui.show()
	launchesCounter.text = launches
	bouncesCounter.text = bounces
	

func _on_LevelButton_blurred(level):
	if(current_hovered == level):
		ui.hide()
		current_hovered = null
