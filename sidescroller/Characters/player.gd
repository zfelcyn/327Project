extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -120.0
const GRAVITY = 150.0

@export var max_health := 100
var current_health = max_health
var is_dead = false  # Track if the character is dead to stop other actions

@onready var animated_sprite = $AnimatedSprite2D
@onready var health_label = $"../CanvasLayer/HealthLabel"  # Reference to the health label node (optional)

var is_jumping = false

func _ready():
	# Initialize the health display on start
	update_health_display()  # Call function to set initial health display

func _physics_process(delta: float) -> void:
	if is_dead:
		return  # Stop movement and input if dead

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		is_jumping = false  # Reset jump state when on the floor

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		# Play jump animation immediately upon jumping
		if abs(velocity.x) > 0:
			animated_sprite.play("jump_side")
		else:
			animated_sprite.play("jump_for")

	# Get the input direction and handle movement/deceleration
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0 and not is_jumping:
		velocity.x = direction * SPEED
		# Play the "left" or "right" animation based on movement direction
		if direction > 0:
			animated_sprite.play("right")
		else:
			animated_sprite.play("left")
	elif not is_jumping:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 2)
		animated_sprite.play("default")  # Play "default" animation when not moving

	# Apply movement
	move_and_slide()

func take_damage(amount: int) -> void:
	current_health -= amount
	update_health_display()

	# Play damaged animation
	if current_health > 0:
		animated_sprite.play("damaged")

	if current_health <= 0:
		die()

func heal(amount: int) -> void:
	if is_dead:
		return  # Do not heal if dead

	current_health = min(current_health + amount, max_health)
	update_health_display()

# Define update_health_display() to update the health display
func update_health_display():
	if health_label:
		health_label.text = "Health: " + str(current_health)

func die() -> void:
	is_dead = true
	animated_sprite.play("dead")
	print("Character has died.")
	queue_free()  # Optionally, remove the character from the scene
