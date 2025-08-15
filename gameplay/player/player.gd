class_name Player
extends CharacterBody2D

@export var speed = 500.0
@export var bullet_speed = 600.0
@export var simple_bullet: PackedScene
@onready var screen_width = get_viewport_rect().size.x
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_timer: Timer = $ShootTimer
@onready var frame_texture := anim_sprite.sprite_frames.get_frame_texture(anim_sprite.animation, 0)
@onready var frame_width := frame_texture.get_width()
@onready var frame_height := frame_texture.get_height()
@onready var half_height := frame_height / 2
@onready var half_width = frame_width / 2

@export var bullet_padding = 10 # pixels up from player spaceship

signal bullet_hit_enemy(enemy: Node)

func _ready() -> void:
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)

func _physics_process(_delta: float) -> void:
	self.velocity = Vector2.ZERO
	
	if Input.is_action_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		if mouse_pos.x < screen_width / 2:
			self.velocity.x = -speed
		else:
			self.velocity.x = speed

	move_and_slide()
	# Clamp inside the screen
	self.position.x = clamp(position.x, half_width, screen_width - half_width)
func _on_shoot_timer_timeout() -> void:
	shoot_simple_bullet()
	
func shoot_simple_bullet() -> void:
	if not simple_bullet:
		return
	var bullet = simple_bullet.instantiate()
	bullet.position = Vector2(self.position.x, self.position.y - half_height - bullet_padding)
	bullet.enemy_hit.connect(_on_bullet_hit)
	get_tree().current_scene.add_child(bullet)
	
func _on_bullet_hit(enemy):
	emit_signal("bullet_hit_enemy", enemy)
