class_name SimpleBullet
extends Area2D

@export var speed = 700
var direction = Vector2.UP

signal enemy_hit(enemy: Node)

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is SimpleEnemy:
		emit_signal("enemy_hit", body)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
