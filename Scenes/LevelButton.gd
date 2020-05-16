extends TextureButton

var MainInstances = ResourceLoader.MainInstances

signal select_level

onready var label = $Label

export(int) var level = 0

func _ready():
	label.text = str(level)

func disable():
	disabled = true;

func enable():
	disabled = false;

func _on_LevelButton_pressed():
	GameManager.current_level = level
	emit_signal("select_level")
