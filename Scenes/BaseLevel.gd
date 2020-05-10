extends Node2D

onready var initialPosition = $InitialPosition
var MainInstances = ResourceLoader.MainInstances
var holes : Array;

func _ready():
	MainInstances.Player.position = initialPosition.position
	MainInstances.Player.initial_position = initialPosition.position
	print("level ready")
	holes = get_tree().get_nodes_in_group("Holes")
	
func queue_free():
	for hole in get_tree().get_nodes_in_group("Holes"):
		hole.queue_free()
	print("level_free")
	.queue_free()
