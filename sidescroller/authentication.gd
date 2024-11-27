extends Control

# Script-level variable to store the username
var username: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect Firebase signals
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

	# Check if the user is already logged in
	if Firebase.Auth.check_auth_file():
		$VBoxContainer/StateLabel.text = "Logged In"  # Corrected node access
		get_tree().change_scene_to_file("res://Levels/test_level.tscn")
		
	# Set placeholder text for input fields
	$VBoxContainer/Email_LineEdit.placeholder_text = "Enter your email"
	$VBoxContainer/Password_LineEdit.placeholder_text = "Enter your password"

	# Ensure password input is masked
	$VBoxContainer/Password_LineEdit.secret = true  # Hides the password input

# Called when the login button is pressed.
func _on_login_button_pressed() -> void:
	var email = $VBoxContainer/Email_LineEdit.text.strip_edges()  # Removes unnecessary spaces
	var password = $VBoxContainer/Password_LineEdit.text.strip_edges()
	if email.length() == 0 or password.length() == 0:
		$VBoxContainer/StateLabel.text = "Email or Password cannot be empty!"
		return
	Firebase.Auth.login_with_email_and_password(email, password)
	$VBoxContainer/StateLabel.text = "Logging in..."

# Called when the signup button is pressed.
func _on_signup_button_pressed() -> void:
	var email = $VBoxContainer/Email_LineEdit.text.strip_edges()
	var password = $VBoxContainer/Password_LineEdit.text.strip_edges()
	if email.length() == 0 or password.length() == 0:
		$VBoxContainer/StateLabel.text = "Email or Password cannot be empty!"
		return
	Firebase.Auth.signup_with_email_and_password(email, password)
	$VBoxContainer/StateLabel.text = "Signing up..."

# Callback for successful login
func on_login_succeeded(auth):
	print(auth)
	$VBoxContainer/StateLabel.text = "Login Successful"

	# Extract and store username
	var email = $VBoxContainer/Email_LineEdit.text.strip_edges()
	username = email.split("@")[0]  # Get everything before the '@'
	print("Username: ", username)

	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")

# Callback for successful signup
func on_signup_succeeded(auth):
	print(auth)
	$VBoxContainer/StateLabel.text = "Signup Successful"

	# Extract and store username
	var email = $VBoxContainer/Email_LineEdit.text.strip_edges()
	username = email.split("@")[0]  # Get everything before the '@'
	print("Username: ", username)

	get_tree().change_scene_to_file("res://Levels/test_level.tscn")

# Callback for failed login
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$VBoxContainer/StateLabel.text = "Login Failed. Error: %s" % message

# Callback for failed signup
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	$VBoxContainer/StateLabel.text = "Signup Failed. Error: %s" % message
