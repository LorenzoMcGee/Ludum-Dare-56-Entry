extends RigidBody2D
var multiplier = 150 
var projectile = false
var spawnPoint

var rightDistance
var leftDistance

var walking = true
var CoalSpriteAnim2D
var CollShape2D
var toggleDirection = false

func closeNuff(inp,comp,threshold):
	return abs(inp-comp) < threshold

func closeNuffVecs(inpVec,compVec,threshold):
	return (abs(inpVec.x-compVec.x) < threshold) and (abs(inpVec.y-compVec.y) < threshold)
	



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rightDistance = 300
	leftDistance = 200
	spawnPoint = position
	CoalSpriteAnim2D = $"CollisionShape2D/CoalSprite"
	CollShape2D = $"CollisionShape2D"
	CoalSpriteAnim2D.play()
	print ("hello world")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var grounded = closeNuff(linear_velocity.y,0,0.05)
	var velocity
	#walk mode by default
	if(walking):
		rotation = 0
		angular_velocity = 0
		if Input.is_action_just_pressed("Space"):
			linear_velocity  = (Vector2.RIGHT*multiplier*3.0)+(Vector2.UP*multiplier*3.0)
			walking = false
			projectile = true
			rotation = 0
			angular_velocity = 0
		elif(grounded):
			
			#walking code
			if((position.x < spawnPoint.x - leftDistance and !toggleDirection) or (position.x > spawnPoint.x + rightDistance and toggleDirection)):
				toggleDirection = !toggleDirection
			if(!toggleDirection):
				velocity = Vector2.LEFT * multiplier 
				CoalSpriteAnim2D.flip_h = false
			else:
				velocity = Vector2.RIGHT * multiplier 
				CoalSpriteAnim2D.flip_h = true
			linear_velocity = velocity
			print("CODE RUNNING ",position,velocity)
			
	#could also act as a projectile
	elif(projectile):
		lock_rotation = false
		#need to detect if the coalSprite is on the ground
		if(closeNuff(angular_velocity,0,0.2) and grounded):
			walking = true
			projectile = false
			linear_velocity = Vector2.UP*multiplier*2   
			lock_rotation = true
			rotation = 0
			angular_velocity = 0
			
	else:
		pass
	
	
	print(linear_velocity," ",angular_velocity," ",rotation," ",walking," ",projectile)
	
	
	
	
	
	
	"""
	match animationIndex:
		0:
			
		_:
			pass
	
	
	
	
	
	position += velocity
	"""
	
	pass
