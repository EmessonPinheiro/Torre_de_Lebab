extends Area2D

const MIN_X = 730
const MAX_X =865
const MIN_Y = 375
const MAX_Y =460

func _ready() -> void:
	
	self.position.x = rand_range(MIN_X,MAX_X)
	self.position.y = rand_range(MIN_Y,MAX_Y)
	
	pass
