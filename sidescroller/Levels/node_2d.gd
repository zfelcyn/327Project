extends Node2D

# Texture to be repeated
var pipe_texture: Texture

func _ready() -> void:
	# Load the texture
	pipe_texture = preload("res://Art/Personal/Assets/pipe.png")
	if not pipe_texture:
		print("Failed to load texture!")
		return

	# Draw the texture initially
	_redraw_background()

func _redraw_background():
	if not pipe_texture:
		return

	# Get sizes
	var tile_size = pipe_texture.get_size()
	var screen_size = get_viewport().get_visible_rect().size

	# Debug: print sizes
	print("Tile Size: ", tile_size, " Screen Size: ", screen_size)

	# Draw tiles
	for x in range(ceil(screen_size.x / tile_size.x)):
		for y in range(ceil(screen_size.y / tile_size.y)):
			draw_texture(pipe_texture, Vector2(x * tile_size.x, y * tile_size.y))
