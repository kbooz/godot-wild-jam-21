extends TextureButton

var music_buttons = {
	true: preload("res://Assets/UI/audio_on_normal.png"),
	false: preload("res://Assets/UI/audio_off_normal.png")
}

var music_buttons_hover = {
	true: preload("res://Assets/UI/audio_on_hover.png"),
	false: preload("res://Assets/UI/audio_off_hover.png")
}

func _on_MusicButton_pressed():
	Music.toggle_music()
