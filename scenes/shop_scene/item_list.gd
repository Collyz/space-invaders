extends ItemList
var scaling_factor = 20.0

func _ready() -> void:
	_resize_itemlist_font()
	
func _resize_itemlist_font() -> void:
	var viewport_width = get_viewport().size.x
	# Calculate desired font size based on a ratio of viewport height
	var new_font_size = int(viewport_width / scaling_factor) # Adjust this ratio as needed
	add_theme_font_size_override("font_size", new_font_size)
