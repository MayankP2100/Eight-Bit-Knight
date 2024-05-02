extends CharacterBody2D


const SPEED = 10000.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var run_sound = $RunSound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta 

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor():			
		if direction == 0:
			animated_sprite_2d.play("idle")
			run_sound.stop()
		else:
			animated_sprite_2d.play("run")
			run_sound.play()
			if direction < 0:
				animated_sprite_2d.flip_h = true
			elif direction > 0: animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.play("jump")
		
	move_and_slide()
