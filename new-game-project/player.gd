extends Node2D
var proximity_detector
var rb2d
var grabbing = false
var playerSprite
var my_array = []
var SpriteRB
var DoorObj
var FireballScene
var simultaneous_scene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	proximity_detector = $"ObjectArea"
	rb2d = $"PlayerRB2D"
	playerSprite = $"PlayerRB2D/CollisionPolygon2D/PlayerSprite"
	DoorObj = get_tree().get_nodes_in_group("Door")[0]

	FireballScene = preload("res://Fireball.tscn")
	simultaneous_scene = preload("res://ending.tscn").instantiate()
	print(proximity_detector)
	proximity_detector.connect("body_entered", Callable(self, "_on_body_entered"))
	proximity_detector.connect("body_exited", Callable(self, "_on_body_exited"))
	pass # Replace with function body.

func fire_fireball(direction):
	var existingArray = get_tree().get_nodes_in_group("Power")
	
	for i in (existingArray.size()):
		existingArray[i].queue_free()
	
	for i in (8):
		var projectile = FireballScene.instantiate()  # Instance a new projectile
		projectile.set_direction(Vector2.RIGHT*cos((2*PI/8)*i)+Vector2.UP*sin((2*PI/8)*i),i)
		projectile.position = SpriteRB.global_position
		projectile.visible = true
		get_parent().add_child(projectile) 
		projectile.play()  # Play the appropriate animation based on direction

func closeNuff(inp,comp,threshold):
	return abs(inp-comp) < threshold


# Signal handler for when a body enters the Area2D
func _on_body_entered(body):
	#print("Body entered: ", body.name)  # Debugging line
	if body.is_in_group("TinyCreatures"):  # You can assign NPCs to a group
		#print("A tiny creature is within reach!")
		var epromptSprite = body.get_node("EPrompt")
		epromptSprite.visible = true
		my_array.append(body)
		

# Signal handler for when a body exits the Area2D
func _on_body_exited(body):
	if body.is_in_group("TinyCreatures") && body.is_in_group:
		#print("A tiny creature has left reach!")
		var epromptSprite = body.get_node("EPrompt")
		epromptSprite.visible = false
		my_array.remove_at(my_array.size()-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var doorGlobalPos = DoorObj.global_position
	doorGlobalPos.x += 300
	
	print(doorGlobalPos.x,":",rb2d.global_position.x)
	
	if(closeNuff(doorGlobalPos.x,rb2d.global_position.x,40)):
		get_tree().root.add_child(simultaneous_scene)
		get_node("/root/MainNode").visible = false
	
	proximity_detector.position = rb2d.position
	
	if(grabbing and Input.is_action_just_pressed("Space")):
		var inverter = 1
		if($PlayerRB2D/CollisionPolygon2D/PlayerSprite.flip_h):
			inverter *= -1
		SpriteRB.linear_velocity = (Vector2.RIGHT*SpriteRB.multiplier*3.0*inverter)+(Vector2.UP*SpriteRB.multiplier*3.0)
		
		#print("Throwing with velocity: ", SpriteRB.linear_velocity)  # Add this line to debug
		SpriteRB.walking = false
		SpriteRB.projectile = true
		SpriteRB.projectile = true
		SpriteRB.grabbed = false
		SpriteRB.grabbable = false
		grabbing = false
		proximity_detector.monitoring = true
		SpriteRB.Anim2D.animation = &"falling"
		SpriteRB.get_node("SpacePrompt").visible = false
		fire_fireball(Vector2.UP)
		SpriteRB.global_position = SpriteRB.playerPos  # Update the position here
		SpriteRB = null
	
	if(!grabbing and Input.is_action_just_pressed("EKey")):
		if(my_array.size() != 0):
			SpriteRB = my_array[0]
			proximity_detector.monitoring = false
			grabbing = true
			SpriteRB.get_node("SpacePrompt").visible = true
			
		else:
			SpriteRB = null
		
		
	if grabbing:
		var inverter = 1
		if playerSprite.flip_h:
			inverter *= -1
			SpriteRB.Anim2D.flip_h = true
		else:
			SpriteRB.Anim2D.flip_h = false
		SpriteRB.playerPos = rb2d.global_position + Vector2.UP * 50 + (Vector2.RIGHT * 200 * inverter)
		SpriteRB.global_position = SpriteRB.playerPos  # Update the position here
		
	#if grabbing:
		#print("While grabbing - Object Y position: ", SpriteRB.global_position.y,":",rb2d.global_position+Vector2.UP*50+(Vector2.RIGHT*200*1))
	#elif(SpriteRB != null):
		#print("After throwing - Object Y position: ", SpriteRB.global_position.y)
		
	#if(SpriteRB != null):
		#print(SpriteRB.playerPos," ",$PlayerRB2D.global_position)
		
	
	pass
