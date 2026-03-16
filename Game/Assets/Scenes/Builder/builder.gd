extends Area2D

var CanPlace := true
var Bodies := []

func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()
	CanPlace = Bodies.is_empty()
	visible = User.Holding
	$Label.text = str(Bodies)
	if User.Holding:
		if (global_position.x < User.MinMap and global_position.x > 0) and (global_position.y > 0 and  global_position.y < 704) and CanPlace:
			modulate = Color.GREEN
			User.Left = true
		else :
			modulate = Color.RED
			User.Left = false
	else:
		modulate = Color.WHITE
		if User.Left and CanPlace:
			User.Left = false
			var Tower = preload("res://Game/Assets/Scenes/Tower/tower.tscn").instantiate()
			Tower.global_position = global_position - Vector2(32, 32)
			get_parent().get_node("Map/Towers").add_child(Tower)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Tower"):
		if !(body in Bodies):
			Bodies.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Tower"):
		if (body in Bodies):
			Bodies.erase(body)
		if !User.Holding:
			User.Left = false
