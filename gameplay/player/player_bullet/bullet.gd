extends RigidBody2D

func _ready() -> void:
	gravity_scale = 0
	linear_damp = 0
	angular_damp = 0


func _physics_process(_delta: float) -> void:
	# Check if outside screen
	var screen_rect = Rect2(Vector2.ZERO, get_viewport_rect().size)
	if not screen_rect.has_point(global_position):
		queue_free()  # removes the bullet


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
