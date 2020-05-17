extends TextureButton

var music_buttons = {
	true: preload("res://Assets/UI/audio_on.png"),
	false: preload("res://Assets/UI/audio_off.png")
}

func _on_MusicButton_pressed():
	Music.toggle_music()
	texture_normal = music_buttons[Music.is_playing()]
