extends RigidBody2D

var playerSpriteAnim2D
var speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true
	gravity_scale = 0
	speed = 4
	playerSpriteAnim2D = $"CollisionPolygon2D/PlayerSprite"
	playerSpriteAnim2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var linVelVec = Vector2.ZERO
	
	if(Input.is_action_pressed("Shift")):
		speed = 7
	else:
		speed = 4
	
	if(Input.is_action_pressed("UpArrow")):
		linVelVec += Vector2.UP * 100 * speed
	elif(Input.is_action_pressed("DownArrow")):
		linVelVec += Vector2.DOWN * 100 * speed
	
	if(Input.is_action_pressed("LeftArrow")):
		playerSpriteAnim2D.flip_h = true
		linVelVec += Vector2.LEFT * 100 * speed
	elif(Input.is_action_pressed("RightArrow")):
		playerSpriteAnim2D.flip_h = false
		linVelVec += Vector2.RIGHT * 100 * speed
	
	linear_velocity = linVelVec
	
	pass
