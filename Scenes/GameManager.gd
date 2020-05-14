extends Node2D
class_name GameManager

var MainInstances = ResourceLoader.MainInstances
var holes = []

func _ready():
	MainInstances.GameManager = self

func can_pass():
	for hole in holes:
		if(!hole.state == Enums.HOLE_STATE.TOUCHED):
			return false
	return true

func reset_holes():
	for hole in holes:
		hole.reset()
		MainInstances.PlayerTrail.clear_points()
