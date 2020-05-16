extends Node2D

onready var initialPosition = $InitialPosition
onready var labelAnimator = $LabelAnimator

export(bool) var has_animation = false

var MainInstances = ResourceLoader.MainInstances
var holes : Array = [];

func _ready():
	MainInstances.Player.position = initialPosition.position
	MainInstances.Player.initial_position = initialPosition.position
	MainInstances.PlayerTrail.clear_points()
	var tree = get_tree()
	holes = tree.get_nodes_in_group("Holes")
	if(has_animation):
		labelAnimator.play("Entering")
