extends Node2D

var MainInstances = ResourceLoader.MainInstances
var holes = []

func _ready():
	MainInstances.GameManager = self

func can_pass():
	for hole in holes:
		if(!hole.is_touched):
			return false
	return true
