extends Node

var data = {
	"completed_levels": [],
	"records": {}
}

func save_data():
	var save_dict = {
		"completed_levels": GameManager.completed_levels,
		"records": GameManager.records
	}
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	
	save_game.store_line(to_json(save_dict))
	save_game.close()

func load_data():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	save_game.open("user://savegame.save", File.READ)
	
	if not save_game.eof_reached():
		data = parse_json(save_game.get_line())
	
	save_game.close()
