extends Node2D

var MainInstances = ResourceLoader.MainInstances
var holes = []
var current_level = 0
var completed_levels = [] setget set_completed_levels
var records = {}
var game_started = false

var current_record = {
	"launches": 0,
	"bounces": 0
}

func _ready():
	SaverAndLoader.load_data()
	completed_levels = SaverAndLoader.data.completed_levels
	records = SaverAndLoader.data.records if SaverAndLoader.data.has("records") else {} 
	current_level = 0 if (!completed_levels || (completed_levels && !completed_levels.size())) else int(completed_levels.max())

func set_completed_levels(value):
	completed_levels = value

func can_pass():
	for hole in holes:
		if(!hole.state == Enums.HOLE_STATE.TOUCHED):
			return false
	return true

func reset_record():
	current_record.bounces = 0
	current_record.launches = 0

func reset_holes():
	for hole in holes:
		hole.reset()
	MainInstances.PlayerTrail.clear_points()

func update_completed_levels(level = null, store_record = false):
	var lvl = str(level if level else current_level)
	if not completed_levels.has(lvl):
		completed_levels.append(lvl)
	
	if store_record:
		update_record(lvl)

	SaverAndLoader.save_data()

func update_record(level):
	if not records.has(level):
		records[level] = record_to_string(current_record)
		return;
	
	var current_sum = current_record.bounces + current_record.launches
	var previous_record = records[level]
	if not previous_record.has("bounces") and not previous_record.has("launches"):
		return
	
	var previous_sum = int(previous_record.bounces) + int(previous_record.launches)
	if((current_sum > previous_sum) ||
	(current_sum == previous_sum && current_record.launches > int(previous_record.launches))):
		return;
	records[level] = record_to_string(current_record)
	
func record_to_string(record):
	return {
		"launches": str(record.launches),
		"bounces": str(record.bounces)
	}
