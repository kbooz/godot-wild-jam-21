extends Node2D

onready var initialPosition = $InitialPosition
onready var levelName = $Label

var MainInstances = ResourceLoader.MainInstances
var holes : Array = [];

func _ready():
	#print(get_viewport().size.x)
	#levelName.rect_position.x = (get_viewport().size.x / 4 - levelName.rect_size.x / 2)
	MainInstances.Player.position = initialPosition.position
	MainInstances.Player.initial_position = initialPosition.position
	MainInstances.PlayerTrail.clear_points()
	var tree = get_tree()
	holes = tree.get_nodes_in_group("Holes")
	
