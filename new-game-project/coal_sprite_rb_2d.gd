extends RigidBody2D
var multiplier = 150 
var projectile = false
var spawnPoint

var rightDistance
var leftDistance
var grabbed = false

var walking = true
var Anim2D
var CollShape2D
var toggleDirection = false
var Eprompt

var playerPos
var grabbable = false
var negator = 1



func closeNuff(inp,comp,threshold):
	return abs(inp-comp) < threshold

func closeNuffVecs(inpVec,compVec,threshold):
	return (abs(inpVec.x-compVec.x) < threshold) and (abs(inpVec.y-compVec.y) < threshold)
	



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rightDistance = 300
	leftDistance = 200
	spawnPoint = global_position
	Anim2D = $"CollisionShape2D/AnimatedSprite"
	CollShape2D = $"CollisionShape2D"
	Eprompt = $"EPrompt"
	Anim2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#check if grounded
	var grounded = closeNuff(linear_velocity.y,0,0.05) and closeNuff(global_position.y,spawnPoint.y,100)
	#check if grabbable
	grabbable = Eprompt.visible
	
	var velocity
	
	if(grabbable && Input.is_action_just_pressed("EKey")):
		grabbed = true
		playerPos = Vector2.ZERO
		Anim2D.animation = &"falling"
		
	if(Input.is_action_just_pressed("LeftArrow")):
		negator = -1
	elif(Input.is_action_just_pressed("RightArrow")):
		negator = 1
		
	if(!grabbable and !grabbed):
		rotation = 0
		angular_velocity = 0
	
	
	if(!grabbed):
		#walk mode by default
		if(walking):
			rotation = 0
			angular_velocity = 0
			if(grounded):
				#walking code
				if((global_position.x < spawnPoint.x - leftDistance and !toggleDirection) or (global_position.x > spawnPoint.x + rightDistance and toggleDirection)):
					toggleDirection = !toggleDirection
				if(!toggleDirection):
					velocity = Vector2.LEFT * multiplier 
					Anim2D.flip_h = false
				else:
					velocity = Vector2.RIGHT * multiplier 
					Anim2D.flip_h = true
				linear_velocity = velocity
		#could also act as a projectile
		elif(projectile):
			lock_rotation = false
			#need to detect if the coalSprite is on the ground
			if(closeNuff(angular_velocity,0,0.2) and grounded):
				walking = true
				projectile = false
				Anim2D.animation = &"walking"
				linear_velocity = Vector2.UP*multiplier*2   
				lock_rotation = true
				rotation = 0
				angular_velocity = 0
		
	#if it's falling, spawn particles
	if (not grounded):
		pass
			
		
	
	#checks if it falls out of the world
	if(position.y > spawnPoint.y + 300 ):
		print("Resetting position to spawn: ", position)  # Debugging
		global_position = spawnPoint
	
	
	
	
	
	
	
	
	pass
