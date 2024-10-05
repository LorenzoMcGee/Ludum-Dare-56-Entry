extends AnimatedSprite2D
var toggleDirection = 1
var multiplier = 140
var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	print ("hello world")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(position.x < 200 or position.x > 1057):
		toggleDirection *= -1
	
	if(toggleDirection == 1):
		velocity = Vector2.LEFT * multiplier * delta
		flip_h = false
	else:
		velocity = Vector2.RIGHT * multiplier * delta 
		flip_h = true
	
	
	
	position += velocity
	
	
	pass
