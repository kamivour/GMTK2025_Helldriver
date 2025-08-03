# CarController_Simple.gd
extends CharacterBody2D

# Set the constant speed for movement and turning.
@export var SPEED = 100.0
@export var BOOST_SPEED = 200.0 # The new, faster speed
@export var TURN_SPEED = 3.5


func _physics_process(delta):
	# Get player input.
	var turn_input = Input.get_axis("move_left", "move_right")
	var move_input = Input.get_axis("move_down", "move_up")

	# Apply rotation directly.
	rotation += turn_input * TURN_SPEED * delta

	# Determine which speed to use.
	var current_speed = SPEED
	if Input.is_action_pressed("boost"):
		current_speed = BOOST_SPEED

	# Calculate velocity using the current speed.
	var direction = Vector2.UP.rotated(rotation)
	velocity = direction * move_input * current_speed

	move_and_slide()