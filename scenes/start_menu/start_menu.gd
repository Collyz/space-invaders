extends Control

@onready var start_menu_bg = $StartMenuBg
@onready var title_label = $VBoxContainer/TitleLabel
@onready var start_sprite = $Sprite2D
@onready var start_button = $Button
@onready var screen_size = get_viewport_rect().size
@onready var screen_height = screen_size.y
@onready var screen_width = screen_size.x

var shader_time := 0.0
var scale_speed := 4

func _ready():
	resize_start_sprite()
	reposition_start_sprite()
	
	
func _process(delta):
	pass

func reposition_start_sprite() -> void:
	start_sprite.position.x = screen_width/2 
	start_sprite.position.y = screen_height/2
	
func resize_start_sprite() -> void:
	var target_width = screen_width * 0.3   # half the screen width
	var target_height = screen_height * 0.3 # half the screen height

	var scale_x = target_width / start_sprite.texture.get_width()
	var scale_y = target_height / start_sprite.texture.get_height()

	var uniform_scale = min(scale_x, scale_y)
	start_sprite.scale = Vector2(uniform_scale, uniform_scale)



func _on_button_pressed():
	var msg = 'Hello World!'
	if title_label.text != msg:
		title_label.text = msg
	else:
		title_label.text = "Space Invaders"
