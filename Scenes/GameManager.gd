extends Node2D

var MainInstances = ResourceLoader.MainInstances
var holes = []
var current_level = 0
var completed_levels = [] setget set_completed_levels
var game_started = false

func _ready():
	SaverAndLoader.load_data()
	completed_levels = SaverAndLoader.data.completed_levels
	current_level = 0

func set_completed_levels(value):
	completed_levels = value

func can_pass():
	for hole in holes:
		if(!hole.state == Enums.HOLE_STATE.TOUCHED):
			return false
	return true

func reset_holes():
	for hole in holes:
		hole.reset()
	MainInstances.PlayerTrail.clear_points()

func update_completed_levels(level):
	var lvl = level if level else current_level
	if not completed_levels.has(str(lvl)):
		completed_levels.append(str(lvl))
	SaverAndLoader.save_data()
