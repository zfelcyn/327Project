extends AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Initialization if needed

func _process(delta: float) -> void:
	# Reference the parent CharacterBody2D node
	var character_body = get_parent() as CharacterBody2D
	if character_body == null:
		print("Error: Parent is not CharacterBody2D.")
		return

	# Determine animation based on character state
	if character_body.is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			# Play jump animation
			character_body.velocity.y = JUMP_VELOCITY
			play("jump")
		elif abs(character_body.velocity.x) > 0:
			# Play run animation if moving horizontally
			play("run")
			flip_h = character_body.velocity.x < 0  # Flip sprite based on direction
		else:
			# Play idle animation if no horizontal movement
			play("front_idle")
	else:
		# Play fall animation if in the air and moving downward
		if character_body.velocity.y > 0:
			play("fall")
