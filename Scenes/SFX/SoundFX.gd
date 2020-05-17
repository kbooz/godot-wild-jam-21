extends Node

var sounds_path = "res://Assets/Sounds/"

var sounds = {
	"Attach": load(sounds_path + "Attach.wav"),
	"Die": load(sounds_path + "Die.wav"),
	"Glue": load(sounds_path + "Glue.wav"),
	"Launch": load(sounds_path + "Launch.wav"),
	"Win": load(sounds_path + "Win.wav"),
	"Bounce": load(sounds_path + "Bounce.wav"),
	"Bounce0": load(sounds_path + "BounceVariation/Bounce +0.wav"),
	"Bounce1": load(sounds_path + "BounceVariation/Bounce +1.wav"),
	"Bounce2": load(sounds_path + "BounceVariation/Bounce +2.wav"),
	"Bounce3": load(sounds_path + "BounceVariation/Bounce +3.wav"),
	"Bounce4": load(sounds_path + "BounceVariation/Bounce +4.wav"),
	"Bounce5": load(sounds_path + "BounceVariation/Bounce +5.wav"),
	"Bounce6": load(sounds_path + "BounceVariation/Bounce +6.wav"),
	"Bounce7": load(sounds_path + "BounceVariation/Bounce +7.wav"),
	"Bounce8": load(sounds_path + "BounceVariation/Bounce +8.wav"),
	"Bounce9": load(sounds_path + "BounceVariation/Bounce +9.wav"),
	"Bounce10": load(sounds_path + "BounceVariation/Bounce +10.wav"),
	"Bounce11": load(sounds_path + "BounceVariation/Bounce +11.wav"),
	"Bounce12": load(sounds_path + "BounceVariation/Bounce +12.wav"),
	"Bounce13": load(sounds_path + "BounceVariation/Bounce +13.wav"),
	"Bounce14": load(sounds_path + "BounceVariation/Bounce +14.wav"),
	"Bounce15": load(sounds_path + "BounceVariation/Bounce +15.wav"),
	"Bounce16": load(sounds_path + "BounceVariation/Bounce +16.wav"),
	"Bounce17": load(sounds_path + "BounceVariation/Bounce +17.wav"),
	"Bounce18": load(sounds_path + "BounceVariation/Bounce +18.wav"),
}

onready var sound_players = get_children()

func _process(_delta):
	if(Input.is_action_just_pressed("ui_mute_sfx")):
		Configuration.muted_sfx = !Configuration.muted_sfx

func play(sound_string, pitch_scale = 1, volume_db = 0):
	if !Configuration.muted_sfx:
		for soundPlayer in sound_players:
			if not soundPlayer.playing:
				soundPlayer.pitch_scale = pitch_scale
				soundPlayer.volume_db = volume_db
				soundPlayer.stream = sounds[sound_string]
				soundPlayer.play()
				return

