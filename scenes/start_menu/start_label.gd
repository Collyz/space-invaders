extends Label

func _ready():
	# Initial adjustment on ready
	_adjust_font_size()

func _on_viewport_resized():
	# Adjust font size when viewport resizes
	_adjust_font_size()

func _adjust_font_size():
	var viewport_height = get_viewport().size.y
	# Calculate desired font size based on a ratio of viewport height
	var new_font_size = int(viewport_height / 30.0) # Adjust this ratio as needed
	add_theme_font_size_override("font_size", new_font_size)
