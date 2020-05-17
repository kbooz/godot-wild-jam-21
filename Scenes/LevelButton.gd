extends TextureButton

var MainInstances = ResourceLoader.MainInstances

signal select_level
signal hovered
signal blurred

onready var label = $Label

export(int) var level = 0

func _ready():
	label.text = str(level)
	self.is_hovered()

func disable():
	disabled = true;

func enable():
	disabled = false;

func _on_LevelButton_pressed():
	SoundFX.play("Win", 1)
	GameManager.current_level = level - 1
	emit_signal("select_level")

func _on_LevelButton_mouse_entered():
	emit_signal("hovered", level)

func _on_LevelButton_mouse_exited():
	emit_signal("blurred", level)
