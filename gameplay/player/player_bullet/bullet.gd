extends RigidBody2D

func _ready() -> void:
	gravity_scale = 0
	linear_damp = 0
	angular_damp = 0

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
