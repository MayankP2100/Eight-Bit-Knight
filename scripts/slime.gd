extends Node2D

const SPEED = 60
var direction = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true

	position.x += direction * SPEED * delta
