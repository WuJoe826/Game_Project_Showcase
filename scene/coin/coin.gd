extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var animation = $AnimatedSprite2D
	
	animation.play("rotate")
