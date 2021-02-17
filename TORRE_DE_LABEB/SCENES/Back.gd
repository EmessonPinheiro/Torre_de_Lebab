extends Button


func _ready() -> void:
	pass


func _on_Back_pressed() -> void:
	get_tree().change_scene("res://SCENES/MenuPrincipal.tscn")
	self.queue_free()
	pass # Replace with function body.
