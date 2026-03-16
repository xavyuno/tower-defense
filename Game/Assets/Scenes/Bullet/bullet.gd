extends Area2D

var Speed = 100

func _physics_process(delta: float) -> void:
	position += transform.x * Speed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.get_parent().Health -= 10
		queue_free()
