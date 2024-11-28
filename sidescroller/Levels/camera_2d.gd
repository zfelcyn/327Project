extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make this camera the active camera
	make_current()
	print("Camera2D is now active and following the player.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get the player node
	var player = $"/root/TestLevel/Player"  # Adjust this path if your scene tree changes
	if player:
		# Update the camera's position to follow the player
		global_position = player.global_position
	else:
		print("Player node not found in the scene tree.")
