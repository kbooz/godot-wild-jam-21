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
	SoundFX.play("Win", 1)
	GameManager.current_level = level - 1
	emit_signal("select_level")
