extends AnimatedSprite2D

var speed = 400  # Speed of the projectile
var direction = Vector2.DOWN
var velocity
var candleObj
var elapsedTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction.normalized() * speed
	candleObj = get_tree().get_nodes_in_group("RequireFlame")
	elapsedTime = 0
	#print(candleObj)


func closeNuffVecs(inpVec,compVec,threshold):
	return (abs(inpVec.x-compVec.x) < threshold) and (abs(inpVec.y-compVec.y) < threshold)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsedTime += delta
	
	if(elapsedTime>3):
		queue_free()
	
	var candleGlobalPos = candleObj[0].global_position
	if(closeNuffVecs(candleGlobalPos,global_position,100)):
		candleObj[0].animation = &"on"
		candleObj[0].play()
	
	#print(candleGlobalPos,global_position)
	
	position += velocity * delta
	if position.y < -100 or position.y > 1000:  # Example of destroying when out of bounds
		queue_free()

func set_direction(new_direction: Vector2,i):
	direction = new_direction
	rotation = -(2*PI/8)*i


	
		
