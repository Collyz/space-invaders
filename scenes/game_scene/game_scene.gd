extends Node2D

@onready var bg = $ColorRect
@onready var pause_btn = $PauseBtn
@onready var screen_size = get_viewport_rect().size

var player_count: int = 2
var score: int = 0
var player_preload = preload("res://gameplay/player/player.tscn")
var player: Player = null

func _ready() -> void:
	_resize_bg()
	player = player_preload.instantiate()
	_place_player()
	self.add_child(player)

func _resize_bg() -> void:
	bg.size = screen_size

func _place_player() -> void:
	if player != null:
		var middle = screen_size.x / 2
		var bottom_fifth = screen_size.y / 5 * 4
		player.position = Vector2(middle, bottom_fifth)
