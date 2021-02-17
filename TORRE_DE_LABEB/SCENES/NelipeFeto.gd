extends Node2D

var ataqueMeteoro


func _ready() -> void:
	
	
	pass


func _on_Timer_timeout() -> void:
	
	ataqueMeteoro = rand_range(0,20)
	if ataqueMeteoro > 10:
		get_tree()
	
	
	pass # Replace with function body.
