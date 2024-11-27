extends Area2D

@export var panel_off_frames := [Vector2(3, 2), Vector2(2, 2)]  # Frames for "off" state
@export var panel_on_frames := [Vector2(4, 2), Vector2(5, 2)]   # Frames for "on" state
@export var frame_interval := 0.5  # Time between frames in seconds
@export var interact_key := "ui_accept"  # Key to interact

@export var tilemap_path: NodePath  # Exported NodePath to assign TileMap
@onready var tilemap = get_node(tilemap_path)  # Use tilemap_path to reference TileMap

var is_panel_on = false
var current_frame_index = 0

func _ready():
	if tilemap == null:
		print("TileMap not found. Please check the assigned path.")
	else:
		print("TileMap found successfully.")
	
	set_process(true)
	# Start the animation loop
	animate_panel()

func animate_panel() -> void:
	while true:
		# Set the correct frame based on the current state and frame index
		var frames = panel_on_frames if is_panel_on else panel_off_frames
		var tile_pos = tilemap.world_to_map(global_position)
		tilemap.set_cellv(tile_pos, tilemap.tile_set.tile_get_id(frames[current_frame_index]))

		# Update the frame index to alternate frames
		current_frame_index = (current_frame_index + 1) % frames.size()

		# Wait for the next frame interval
		await get_tree().create_timer(frame_interval).timeout

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("Player entered interaction area")

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		print("Player exited interaction area")

func _process(delta):
	# Check for interaction input when the player is within the area
	if Input.is_action_just_pressed(interact_key):
		toggle_panel()

func toggle_panel():
	# Switch between "off" and "on" states
	is_panel_on = !is_panel_on
	current_frame_index = 0  # Reset to the first frame in the new animation
