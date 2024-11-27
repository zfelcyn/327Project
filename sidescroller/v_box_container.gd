extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set spacing between elements
	set("custom_constants/separation", 40)  # Increase space between child nodes

	# Position the VBoxContainer lower on the screen
	anchor_left = 0.5
	anchor_right = 0.5
	anchor_top = 0.4  # Start lower vertically
	anchor_bottom = 0.9  # Extend lower vertically
	offset_left = -200
	offset_right = 200
	offset_top = -100  # Adjust for a lower position
	offset_bottom = 150

	# Customize the StateLabel
	var state_label = get_node("StateLabel")
	state_label.text = "Welcome to Authentication"
	state_label.horizontal_alignment = 1  # Center-align text

	# Customize the Email_LineEdit
	var email_input = get_node("Email_LineEdit")
	email_input.placeholder_text = "Enter your email"  # Placeholder text

	# Customize the Password_LineEdit
	var password_input = get_node("Password_LineEdit")
	password_input.placeholder_text = "Enter your password"  # Placeholder text
	password_input.secret = true  # Mask the input

	# Center-align the Login Button
	var login_button = get_node("Login_Button")
	login_button.text = "Login"
	login_button.size_flags_horizontal = Control.SIZE_EXPAND

	# Center-align the Signup Button
	var signup_button = get_node("Signup_Button")
	signup_button.text = "Sign Up"
	signup_button.size_flags_horizontal = Control.SIZE_EXPAND
