extends Node2D

var input = TextEdit.new()
var output = RichTextLabel.new()
@export var open = KEY_BRACKETLEFT # use any key you want to open menu
@export var close = KEY_BRACKETRIGHT # use any key you want to close menu
@export var corner = "right"

# executed at beginning
func _ready():
	add_child(input)
	makeInput()
	add_child(output)
	makeOutput()
	set_visible(false)

# executed every frame
func _process(delta):
	
	if Input.is_key_pressed(open):
		set_visible(true)
	elif Input.is_key_pressed(close):
		set_visible(false)

	if input.text.ends_with("`"):
		getInput()

func makeInput():
	# size of window x value, size of window y value divided by 10
	input.size = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y / 10)
	# size of window - size of text box
	input.position.y = get_viewport_rect().size.y-input.size.y
	input.theme = load("./theme.tres")

func getInput():
	# switch statement for all the commands
	match input.text:
		"q`":
			print("working")
			clear()
		"w`":
			print("working2")
			clear()

func makeOutput():
	pass

func clear():
	# called to clear textEdit after every command
	input.text = ""
