extends Node2D

var input = TextEdit.new()
var output = RichTextLabel.new()
@export var open = KEY_BRACKETLEFT # use any key you want to open gonsole
@export var close = KEY_BRACKETRIGHT # use any key you want to close gonsole
@export var corner = "right" # what corner do u want it, left or right
@export var enter = "'" # what button to execute script

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

	#if it ends with the button you want it to end with
	if input.text.ends_with(enter):
		getOutput(input.text)

func makeInput():
	# size of window x value, size of window y value divided by 10
	input.size = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y / 10)
	# size of window - size of text box
	input.position.y = get_viewport_rect().size.y-input.size.y
	input.theme = load("./theme.tres")

func makeOutput():
	# making it look how its supposed to look
	output.theme = load("./theme.tres")
	output.size = Vector2(get_viewport_rect().size.x/4,get_viewport_rect().size.y-input.size.y)
	match corner:
		"right":
			output.position = Vector2(output.size.x*3,0)
		"left":
			output.position = Vector2.ZERO
func getOutput(cmd):
	var optxt = ""
	var cmdlist = ["w","q"]
	# giant if/else statement because match doesn't work with list values
	if cmd == getCMD(cmdlist[0]):
		optxt += "w working"
		clear(input)
	elif cmd == getCMD(cmdlist[1]):
		optxt += "q working"
		clear(input)
	else:
		clear(input)
	# if/else statement to check whether it's the first line or another line for newline
	if output.text == "":
		output.text = optxt
	else:
		output.text += "\n" + optxt
	output.scroll_to_line(output.get_line_count()-1)
func getCMD(letter):
	return letter + enter


func clear(textname):
	# called to clear textEdit after every command
	textname.text = ""
