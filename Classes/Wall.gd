extends StaticBody2D


onready var sprite = $Sprite
onready var collisionShape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var spriteSize = sprite.texture.get_size();
	collisionShape.get_shape().set_extents(spriteSize/2)
