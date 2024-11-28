extends TileMapLayer

# Constants for Tileset and tile IDs
const TILESET_ID = 0
const UNACTIVE_TILE_ID = 2
const ACTIVE_TILE_ID = 1
const TARGET_POSITION = Vector2(-4, 3)
const DELAY = 10.0  # Delay in seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	print("TileMapLayer _ready() called")  # Debug print

	# Access the TileMap node which holds the TileMapLayer
	var tilemap = get_parent() as TileMap  # Assuming TileMapLayer is directly inside TileMap
	
	if tilemap:
		print("TileMap found as parent")  # Debug print
		# Ensure the TileMap is using the correct Tileset
		var tileset = tilemap.tileset
		if tileset and tileset.get_id() == TILESET_ID:
			print("Tileset ID matches:", TILESET_ID)  # Debug print
			# Set the initial tile (unactive)
			tilemap.set_cellv(TARGET_POSITION, UNACTIVE_TILE_ID)
			print("Initial tile set to UNACTIVE at position:", TARGET_POSITION)  # Debug print
			# Await for the delay and then swap the tile
			await delay_change_tile(tilemap)
		else:
			push_error("TileMap is not using the correct Tileset with ID: " + str(TILESET_ID))
			print("Tileset ID does not match:", tileset.get_id())  # Debug print
	else:
		push_error("No TileMap found as parent.")
		print("TileMap parent not found.")  # Debug print

# Function to swap the tile after a delay
func delay_change_tile(tilemap: TileMap) -> void:
	print("Waiting for delay...")  # Debug print
	# Wait for the specified delay (10 seconds)
	await get_tree().create_timer(DELAY).timeout
	print("Delay complete, changing tile...")  # Debug print
	# Change the tile to the active tile
	tilemap.set_cellv(TARGET_POSITION, ACTIVE_TILE_ID)
	print("Tile changed to ACTIVE at position:", TARGET_POSITION)  # Debug print
