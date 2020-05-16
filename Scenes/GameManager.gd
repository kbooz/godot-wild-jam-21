extends Node2D

var MainInstances = ResourceLoader.MainInstances
var holes = []
var current_level = 0

func _ready():
	current_level = 0

func can_pass():
	for hole in holes:
		if(!hole.state == Enums.HOLE_STATE.TOUCHED):
			return false
	return true

func reset_holes():
	for hole in holes:
		hole.reset()
		MainInstances.PlayerTrail.clear_points()
