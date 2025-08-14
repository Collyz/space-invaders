extends Label
var scaling_factor = 20.0

func _ready() -> void:
	_adjust_font_size()

func _adjust_font_size():
	var viewport_width = get_viewport().size.x
	var new_font_size = int(viewport_width / scaling_factor) 
	add_theme_font_size_override("font_size", new_font_size)
