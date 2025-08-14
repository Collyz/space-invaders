extends Node2D

@onready var bg = $ColorRect
@onready var pause_btn = $PauseBtn
@onready var screen_size = get_viewport_rect().size

var player_count = 2
var player_preload = preload("res://gameplay/player/player.tscn")
var player: Player = null

func _ready() -> void:
	_resize_bg()
	player = player_preload.instantiate()
	
	self.add_child(player)

func _resize_bg() -> void:
	bg.size = screen_size
