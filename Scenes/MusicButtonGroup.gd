extends Control

onready var MusicOnButtton = $MusicButton
onready var MusicOffButton = $MusicOffButton

func _on_MusicButton_pressed():
	Music.toggle_music()
	MusicOnButtton.visible = false
	MusicOffButton.visible = true
	MusicOnButtton.toggle_mode = false

func _on_MusicOffButton_pressed():
	Music.toggle_music()
	MusicOffButton.visible = false
	MusicOnButtton.visible = true
	MusicOnButtton.toggle_mode = false
	
