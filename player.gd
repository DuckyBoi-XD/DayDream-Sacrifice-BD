extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -550.0
var JUMP_COUNT = 0
var JUMP_WALL_COUNT = 0
var CAN_DOUBLE_JUMP = false
var CAN_WALL_JUMP = false

func _ready():
	var scene_path = get_tree().current_scene.scene_file_path
	
	if scene_path == "res://Level/SecondLevel.tscn" or scene_path == "res://Level/ThirdLevel.tscn" or scene_path == "res://Level/ForthLevel.tscn":
		CAN_DOUBLE_JUMP = true
		print("You can now double jump")
	else:
		CAN_DOUBLE_JUMP = false
	
	if scene_path == "res://Level/ThirdLevel.tscn" or scene_path == "res://Level/ForthLevel.tscn":
		CAN_WALL_JUMP = true
		print("You can now wall jump")
	else:
		CAN_WALL_JUMP = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		JUMP_COUNT = 0

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		JUMP_COUNT = 0
		JUMP_WALL_COUNT = 0
	if CAN_WALL_JUMP == true:
		if Input.is_action_just_pressed("Up") and is_on_wall() and JUMP_WALL_COUNT == 0:
			velocity.y = JUMP_VELOCITY - 100
			JUMP_WALL_COUNT = 1
			JUMP_COUNT = 0
	if CAN_DOUBLE_JUMP == true:
		if Input.is_action_just_pressed("Up") and JUMP_COUNT <= 1:
			velocity.y = JUMP_VELOCITY + 100
			JUMP_COUNT += 1
			JUMP_WALL_COUNT = 0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	
