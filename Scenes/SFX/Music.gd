extends Node

export(Array, AudioStream) var music_list = []

var music_list_index = 0

onready var musicPlayer = $MusicPlayer

func _process(_delta):
	if(Input.is_action_just_pressed("ui_mute_music")):
		toggle_music()

func list_play():
	assert(music_list.size() > 0)
	musicPlayer.stream = music_list[music_list_index]
	musicPlayer.play()
	music_list_index += 1
	if music_list_index == music_list.size():
		music_list_index = 0

func is_playing():
	return musicPlayer.playing

func toggle_music():
	if not musicPlayer.playing:
		list_play()
	else:
		list_stop()

func list_stop():
	musicPlayer.stop()
