extends Button


func _ready() -> void:
	pass


func _on_MenuPrincipal_pressed() -> void:
	get_tree().change_scene("res://SCENES/World.tscn")
	self.queue_free()
	pass # Replace with function body.


func _on_Histria_pressed() -> void:
	get_tree().change_scene("res://SCENES/Historia.tscn")
	self.queue_free()
	pass # Replace with function body.
