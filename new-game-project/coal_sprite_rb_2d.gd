extends RigidBody2D
var multiplier = 25000 
var spinning = false   
var inMotion = false
var CoalSpriteAnim2D
var CollShape2D

func closeNuff(inp,comp,threshold):
	return abs(inp-comp) < threshold

func closeNuffVecs(inpVec,compVec,threshold):
	return (abs(inpVec.x-compVec.x) < threshold) and (abs(inpVec.y-compVec.y) < threshold)
	



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CoalSpriteAnim2D = $"CollisionShape2D/CoalSprite"
	CollShape2D = $"CollisionShape2D"
	CoalSpriteAnim2D.play()
	print ("hello world")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	if Input.is_action_just_pressed("Space"):
		linear_velocity  = (Vector2.RIGHT*multiplier*3.0*delta)+(Vector2.UP*multiplier*3.0*delta)
		spinning = true
		inMotion = true
		rotation = 0
		angular_velocity = 0
		
	if linear_velocity.y < 0:
		lock_rotation = false
	#print(spinning," ",inMotion," ",rotation)
	#print(linear_velocity,angular_velocity,":",spinning,":",CoalSpriteAnim2D.rotation,":",CollShape2D.rotation,":",closeNuff(angular_velocity,0,3),":",closeNuffVecs(linear_velocity,Vector2.ZERO,3),":",angular_velocity)
	
	if(spinning and closeNuff(angular_velocity,0.5,0.1)  and abs(angular_velocity) > 0  ):
		spinning = false
		linear_velocity = Vector2.UP*delta*multiplier
	elif(not spinning and inMotion):
		angular_velocity = 0
		rotation = 0
		inMotion = false
	elif(not inMotion):
		angular_velocity = 0
		lock_rotation = true
		rotation = 0
		print("test")
		
	
	
	"""
	match animationIndex:
		0:
			if(position.x < 200 or position.x > 1057):
				toggleDirection *= -1
			if(toggleDirection == 1):
				velocity = Vector2.LEFT * multiplier * delta
				flip_h = false
			else:
				velocity = Vector2.RIGHT * multiplier * delta 
				flip_h = true
		_:
			pass
	
	
	
	
	
	position += velocity
	"""
	
	pass
