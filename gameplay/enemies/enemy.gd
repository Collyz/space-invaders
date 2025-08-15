class_name SimpleEnemy
extends Node2D

@export var move_speed = 600.0
var direction := 1

@onready var screen_size := get_viewport_rect().size
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var texture: Texture2D = anim_sprite.sprite_frames.get_frame_texture(anim_sprite.animation, 0)
@onready var sprite_width := texture.get_width() * scale.x


#func _process(delta: float) -> void:
	#position.x += direction * move_speed * delta


func _on_left_visible_on_screen_notifier_2d_screen_exited() -> void:
	direction = 1

func _on_right_visible_on_screen_notifier_2d_screen_exited() -> void:
	direction = -1
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("hit")
