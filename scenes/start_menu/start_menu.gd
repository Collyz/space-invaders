extends Control

@onready var start_menu_bg = $StartMenuBg
@onready var title_label = $TitleLabel
@onready var start_button = $Button
@onready var start_label = $StartLabel
@onready var screen_size = get_viewport_rect().size
@onready var screen_height = screen_size.y
@onready var screen_width = screen_size.x

var time_accum := 0.0
var scale_speed := 4

func _ready():
	# Set the background and button size to be the entire screen
	start_menu_bg.size = get_viewport_rect().size
	start_button.size = get_viewport_rect().size
	reposition_title()
	reposition_start_label()
	
	start_label.pivot_offset = start_label.size / 2
	#start_label.pivot_offset = start_label.pivot_offset.round() # pixel align
	
func _process(delta):
	# Pulse size (breathing effect)
	time_accum += delta
	var scale_factor = 1.0 + 0.05 * sin(time_accum * scale_speed) * 4 # ±5% scale
	start_label.scale = Vector2(scale_factor, scale_factor)

func reposition_title() -> void:
	# Move the title label to be center aligned and the y pos to be 1/6 of the height of the screen
	title_label.position.x = screen_width/2 - title_label.size.x/2
	title_label.position.y = screen_height/6

func reposition_start_label() -> void:
	# Move the start label to the center of the screen
	start_label.position.x = screen_width/2 - start_label.size.x/2
	start_label.position.y = screen_height/2

func _on_button_pressed():
	var msg = 'Hello World!'
	if title_label.text != msg:
		title_label.text = msg
	else:
		title_label.text = "Space Invaders"
