extends Button

@onready var screen_size = get_viewport_rect().size
var scaling_factor = 10.0

func _ready() -> void:
	_scale_btn()
	_move_scale_pause_btn()
	
func _scale_btn():
	var target_size = screen_size.x / scaling_factor
	var scale_factor = target_size / self.size.x * .7# Square sprite
	self.scale = Vector2(scale_factor, scale_factor)

func _move_scale_pause_btn() -> void:
	var scaled_width = self.size.x * self.scale.x
	var scaled_height = self.size.y * self.scale.y
	var width_factor = 1.5 # Increase distance from the side of the screen
	var height_factor = 3 #Buttons can't be slightly offscreen? SO only need half its height, its already on the screen
	self.position = Vector2(screen_size.x - scaled_width * width_factor, scaled_height * height_factor)

func _on_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/start_menu/start_menu.tscn")
