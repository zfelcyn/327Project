extends VBoxContainer

# Called when the node enters the scene tree
func _ready() -> void:
	# Set up the sign-out button
	var signout_button = $SignOut_Button
	signout_button.text = "Sign Out"

	# Set up the save button
	var save_button = $Save_Button
	save_button.text = "Save"
	save_button.connect("pressed", Callable(self, "_on_save_button_pressed"))

# Handle the sign-out button press
func _on_sign_out_button_pressed() -> void:
	# Clear the authentication file
	Firebase.Auth.logout()
	
	# Redirect to the authentication screen
	get_tree().change_scene_to_file("res://Authentication.tscn")

# Handle the save button press
func _on_save_button_pressed() -> void:
	# Example data to save (modify this as needed)
	var data_to_save = {
		"username": $Username_LineEdit.text.strip_edges(),  # Example input field
		"score": 100  # Example static value
	}

	# Save data to Firebase Database
	Firebase.Database.set_value_async("/users/" + Firebase.Auth.get_current_user_id(), data_to_save).then(
		func(response):
		print("Data saved successfully: ", response)
		).catch(
		func(error):
		print("Failed to save data: ", error)
		)
