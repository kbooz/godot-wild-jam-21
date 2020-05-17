extends Node2D

onready var initialPosition = $InitialPosition
onready var launchesCounter = $Control/UI/LaunchesCounter
onready var bouncesCounter = $Control/UI/BouncesCounter

var MainInstances = ResourceLoader.MainInstances
var holes : Array = [];

func _ready():
	MainInstances.Player.initial_position = initialPosition.position
	MainInstances.Player.initialize()
	MainInstances.PlayerTrail.clear_points()
	MainInstances.Player.connect("bounced", self, "_on_Player_bounced")
	MainInstances.Player.connect("launched", self, "_on_Player_launched")
	var tree = get_tree()
	holes = tree.get_nodes_in_group("Holes")	
	
func _on_Player_bounced():
	GameManager.current_record.bounces += 1
	render_UI()

func _on_Player_launched():
	GameManager.current_record.launches += 1
	render_UI()

func render_UI():
	launchesCounter.text = str(GameManager.current_record.launches)
	bouncesCounter.text = str(GameManager.current_record.bounces)
