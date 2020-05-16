extends Camera2D

var MainInstances = ResourceLoader.MainInstances

var shake = 0
var initialPosition = position

onready var timer = $ScreenshakeTimer

func _ready():
	Events.connect("add_screenshake", self, "_on_Events_add_screenshake")
	MainInstances.MainCamera = self

func queue_free():
	MainInstances.MainCamera = null
	.queue_free()

func _process(delta):
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)

func screenshake(amount, duration):
	shake = amount
	timer.wait_time = duration
	timer.start()

func _on_ScreenshakeTimer_timeout():
	shake = 0

func _on_Events_add_screenshake(amount, duration):
	screenshake(amount, duration)
