extends Control


func _on_game_btn_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/game_scene/game_scene.tscn")



func _on_menu_btn_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/start_menu/start_menu.tscn")
