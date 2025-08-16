extends Node2D

@export var simple_enemy: PackedScene
@export var player_preload: PackedScene

@onready var bg = $ColorRect
@onready var pause_btn = $PauseBtn
@onready var score_label = $ScoreLabel
@onready var enemies_holder = $EnemiesHolder
@onready var screen_size = get_viewport_rect().size

var enemies = []
var enemies_per_row = 10
var enemies_per_col = 3

var player_count: int = 2
var score: int = 0
var player: Player = null

var enemies_hit_count = 0

signal left_enemy_group_off_screen
signal right_enemy_group_off_screen

func _ready() -> void:
	_resize_bg()
	_initialize_player()
	spawn_enemies()
	_set_score_label()
	_move_score_label()
	self.add_child(player)
	# Attach signal from player to game controler i.e. the scene
	player.bullet_hit_enemy.connect(_update_score)

func _resize_bg() -> void:
	bg.size = screen_size
	
func _set_score_label() -> void:
	score_label.text = "Score: " + str(score)
	
func _move_score_label() -> void:
	score_label.position = Vector2(screen_size.x/2 - score_label.get_rect().end.x * 2, enemies_holder.position.y - 50)

func _initialize_player() -> void:
	player = player_preload.instantiate()
	_place_player()

func _place_player() -> void:
	if not player:
		return
	var middle = screen_size.x / 2
	var bottom_fifth = screen_size.y / 5 * 4
	player.position = Vector2(middle, bottom_fifth)

func _instantiate_simple_enemy() -> SimpleEnemy:
	if not simple_enemy:
		return
	return simple_enemy.instantiate()
	
func spawn_enemies() -> void:
	enemies_holder.position = Vector2(screen_size.x / 2, screen_size.y / 8)
	var screen_width = screen_size.x
	var padding = 75
	var enemy_width = 128
	var enemy_height = 64
	
	# Reset the enemies array
	enemies = []
	for i in range(enemies_per_col):
		enemies.append([])
	
	# Instantiate enemies
	for i in range(enemies_per_col):
		for j in range(enemies_per_row):
			enemies[i].append(_instantiate_simple_enemy())
	
	# Calculate spacing
	var total_enemy_width = enemies_per_row * enemy_width
	var available_gap_space = screen_width - (2 * padding) - total_enemy_width
	var gap_size = available_gap_space / float(enemies_per_row - 1)
	
	# Total width of the whole enemy block
	var block_width = total_enemy_width + (enemies_per_row - 1) * gap_size
	
	# Leftmost x (relative to center, so start at -block_width/2)
	var start_x = -block_width / 2
	
	# Place enemies
	for row in range(enemies.size()):
		for col in range(enemies[row].size()):
			var enemy: SimpleEnemy = enemies[row][col]
			enemies_holder.add_child(enemy)
			
			var x = start_x + col * (enemy_width + gap_size)
			var y = row * enemy_height
			enemy.position = Vector2(x, y)
	
	# Add visible on screen notifier to end of first and last row of enemies
	var notifier_padding = 50
	var left_most_enemy_pos = enemies[0][0].position
	var right_most_enemy_pos = enemies[0][enemies[0].size()-1].position
	
	var left_notifier = VisibleOnScreenNotifier2D.new()
	var right_notifier = VisibleOnScreenNotifier2D.new()
	# Add notifiers to scene tree
	enemies_holder.add_child(left_notifier)
	left_notifier.position.x = left_most_enemy_pos.x - notifier_padding
	enemies_holder.add_child(right_notifier)
	right_notifier.position.x = right_most_enemy_pos.x + notifier_padding
	# Connect the signals
	left_notifier.screen_exited.connect(_on_left_group_off_screen)
	right_notifier.screen_exited.connect(_on_right_group_off_screen)
	

func _on_left_group_off_screen():
	emit_signal("left_enemy_group_off_screen")
	
func _on_right_group_off_screen():
	emit_signal("right_enemy_group_off_screen")
	
func _update_score(enemy) -> void:
	score+= 50
	_set_score_label()
	enemy.queue_free()
	enemies_hit_count += 1
	
	_check_if_enemies_gone()
	

func _check_if_enemies_gone() -> void:
	await get_tree().process_frame
	for i in range(enemies.size()):
		for j in range(enemies[0].size()):
			if enemies[i][j] != null:
				return
	spawn_enemies()
