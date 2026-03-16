extends PathFollow2D

var Health := 100

func _physics_process(delta: float) -> void:
	$Body.force_update_transform()
	progress_ratio += 0.0001
	$Label.text = str(Health)
	if Health <= 0:
		if randi_range(0, 100) >= 0:
			var point = preload("res://Game/Assets/Scenes/Point/point.tscn").instantiate()
			point.global_position = $Body.global_position
			get_parent().get_parent().add_child(point)
		queue_free()
