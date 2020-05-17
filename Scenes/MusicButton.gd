extends TextureButton

var music_buttons = {
	true: preload("res://Assets/UI/audio_on_normal.png"),
	false: preload("res://Assets/UI/audio_off_normal.png")
}

var music_buttons_hover = {
	true: preload("res://Assets/UI/audio_on_hover.png"),
	false: preload("res://Assets/UI/audio_off_hover.png")
}

func _ready():
	Music.connect("mute_music", self, "_on_Music_mute")

func _on_MusicButton_pressed():
	Music.toggle_music()

func _on_Music_mute():
	pressed = Music.is_playing()
	
