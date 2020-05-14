extends Camera2D

func _process(delta: float) -> void:
	translate(Vector2(10, 10) * delta)
