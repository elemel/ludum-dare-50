extends KinematicBody

onready var camera = get_node("Camera")

var velocity = Vector3.ZERO
var speed = 5
var fall_acceleration = 20

var sensitivity = 0.1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.window_fullscreen = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var input_direction = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("move_back"):
		input_direction.y += 1
	if Input.is_action_pressed("move_forward"):
		input_direction.y -= 1
	
	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized().rotated(-rotation.y)
	
	# Ground velocity
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.y * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true)

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

	if event is InputEventMouseMotion:
		var movement = event.relative
		camera.rotation.x -= deg2rad(movement.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * sensitivity)
