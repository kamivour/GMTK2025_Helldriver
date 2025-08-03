# CarController.gd
extends CharacterBody2D

# How fast the car speeds up and turns.
@export var ACCELERATION = 500
@export var MAX_SPEED = 800
@export var FRICTION = 300
@export var TURN_SPEED = 3.0

# The 'velocity' variable is built-in for CharacterBody2D.
# We'll use a separate variable to track speed along the car's forward direction.
var speed = 0.0

func _physics_process(delta):
	# Get input for turning and acceleration
	var turn_input = Input.get_axis("turn_left", "turn_right")
	var move_input = Input.get_axis("move_backward", "move_forward")

	# --- Rotation ---
	# Only allow turning if the car is moving.
	if not is_zero_approx(speed):
		rotation += turn_input * TURN_SPEED * delta

	# --- Acceleration & Friction ---
	if move_input != 0:
		# If there's input, accelerate.
		speed += move_input * ACCELERATION * delta
		speed = clamp(speed, -MAX_SPEED / 2, MAX_SPEED) # Clamp speed (half max speed for reverse)
	else:
		# If no input, apply friction to slow down.
		speed = move_toward(speed, 0, FRICTION * delta)

	# --- Movement ---
	# Set the body's velocity based on its rotation and current speed.
	# Vector2.UP is used because your sprite faces up.
	velocity = Vector2.UP.rotated(rotation) * speed
	
	move_and_slide()