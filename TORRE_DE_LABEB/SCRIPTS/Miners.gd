extends Area2D

const MIN_X = 210
const MAX_X =320
const MIN_Y =400
const MAX_Y =460

func _ready() -> void:
	
	self.position.x = rand_range(MIN_X,MAX_X)
	self.position.y = rand_range(MIN_Y,MAX_Y)
	
	pass
