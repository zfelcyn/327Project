extends CharacterBody2D

const SPEED = 150.0  # Reduced horizontal speed
const JUMP_VELOCITY = -120.0  # Further reduce jump velocity
const GRAVITY = 150.0  # Slightly increase gravity for a quicker descent

@onready var animated_sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		# Play the "left" or "right" animation based on movement direction
		if direction > 0:
			animated_sprite.play("right")
		else:
			animated_sprite.play("left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 2)
		animated_sprite.play("default")  # Play "default" animation when not moving

	# Apply movement
	move_and_slide()
