extends Node2D

@export var move_speed = 300
var direction = 1


func _ready():
	get_parent().left_enemy_group_off_screen.connect(_on_left_visible_on_screen_notifier_2d_screen_exited)
	get_parent().right_enemy_group_off_screen.connect(_on_right_visible_on_screen_notifier_2d_screen_exited)
	

func _process(delta: float) -> void:
	position.x += direction * move_speed * delta

func _on_left_visible_on_screen_notifier_2d_screen_exited() -> void:
	direction = 1

func _on_right_visible_on_screen_notifier_2d_screen_exited() -> void:
	direction = -1
