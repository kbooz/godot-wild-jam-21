extends Line2D
class_name Trail

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		clear_points()
		

func get_last_point():
	var size = self.get_point_count()
	if size > 0:
		return self.get_point_position(size - 1)
	return null

func follow_point(pos: Vector2):
	var size = self.get_point_count()
	if size > 0:
		var last_index = self.get_point_count() - 1
		self.set_point_position(last_index, pos)
	else:
		add_point(pos)
