extends Button

var FollowEnemies := []
var ViewLast := false

func _physics_process(delta: float) -> void:
	if !FollowEnemies.is_empty():
		if get_parent().get_parent().get_node("Path/" + FollowEnemies[0]) != null:
			if ViewLast:
				$Gun.look_at(get_parent().get_parent().get_node("Path/" + FollowEnemies[FollowEnemies.size()-1]).global_position)
			else :
				$Gun.look_at(get_parent().get_parent().get_node("Path/" + FollowEnemies[0]).global_position)

func _on_vision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		if !(body.get_parent().name in FollowEnemies):
			FollowEnemies.append(body.get_parent().name)

func _on_vision_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		if (body.get_parent().name in FollowEnemies):
			FollowEnemies.erase(body.get_parent().name)

func _on_shoot_timeout() -> void:
	if !FollowEnemies.is_empty():
		if get_parent().get_parent().get_node("Path/" + FollowEnemies[0]) != null:
			var Bullet = preload("res://Game/Assets/Scenes/Bullet/bullet.tscn").instantiate()
			Bullet.rotation = $Gun.rotation
			Bullet.global_position = $Gun.global_position
			get_parent().get_parent().add_child(Bullet)
