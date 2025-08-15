extends Node2D

@export var simple_enemy: PackedScene
@export var player_preload: PackedScene

@onready var bg = $ColorRect
@onready var pause_btn = $PauseBtn
@onready var score_label = $ScoreLabel
@onready var enemies_holder = $EnemiesHolder
@onready var screen_size = get_viewport_rect().size

var enemies = []
var enemies_per_row = 5
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
	enemies_holder.position = Vector2(screen_size.x/2, screen_size.y/8)
	var width = screen_size.x
	var arb_dist = 150
	var next_spawn_loc = Vector2.ZERO
	next_spawn_loc.y = 50
	
	# Reset the enemies array
	enemies = []
	for i in range(enemies_per_col):
		enemies.append([])
	
	# Instantiate all of the enemies
	for i in range(enemies_per_col):
		for j in range(enemies_per_row):
			enemies[i].append(_instantiate_simple_enemy())
			
	# Add them to the scene tree at certain positions
	for i in range(enemies.size()):
		for j in range(enemies[0].size()):
			#print(enemies[i][j])
			var enemy: SimpleEnemy = enemies[i][j]
			enemies_holder.add_child(enemies[i][j])
			enemy.position.x = -width / 2 + enemy.sprite_width + arb_dist + next_spawn_loc.x
			enemy.position.y = next_spawn_loc.y
			next_spawn_loc.x += arb_dist + enemy.sprite_width
		next_spawn_loc.x = 0
		next_spawn_loc.y += 150
	
	# Add visible on screen notifier to end of first and last row of enemies
	var padding = 100
	var left_most_enemy_pos = enemies[0][0].position
	var right_most_enemy_pos = enemies[0][enemies[0].size()-1].position
	
	var left_notifier = VisibleOnScreenNotifier2D.new()
	var right_notifier = VisibleOnScreenNotifier2D.new()
	# Add notifiers to scene tree
	enemies_holder.add_child(left_notifier)
	left_notifier.position.x = left_most_enemy_pos.x - padding
	enemies_holder.add_child(right_notifier)
	right_notifier.position.x = right_most_enemy_pos.x + padding
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
