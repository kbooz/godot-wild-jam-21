extends Node2D

export(int) var maxFar = 150

func _process(_delta):
	var anchor: Position2D = get_parent()
	var player: Node2D = anchor.get_parent()
	
	var rot = player.get_local_mouse_position().angle()
	anchor.rotation = rot
