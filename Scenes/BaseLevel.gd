extends Node2D

onready var initialPosition = $InitialPosition

var MainInstances = ResourceLoader.MainInstances
var holes : Array = [];

func _ready():
	MainInstances.Player.initial_position = initialPosition.position
	MainInstances.Player.initialize()
	MainInstances.PlayerTrail.clear_points()
	var tree = get_tree()
	holes = tree.get_nodes_in_group("Holes")
