extends Button

func _on_button_down() -> void:
	User.Holding = true

func _on_button_up() -> void:
	User.Holding = false
