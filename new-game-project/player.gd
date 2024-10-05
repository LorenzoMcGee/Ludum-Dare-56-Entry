extends Node2D
var proximity_detector
var rb2d
var grabbing = false
var my_array = []
var SpriteRB

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	proximity_detector = $"ObjectArea"
	rb2d = $"PlayerRB2D"
	print(proximity_detector)
	proximity_detector.connect("body_entered", Callable(self, "_on_body_entered"))
	proximity_detector.connect("body_exited", Callable(self, "_on_body_exited"))
	pass # Replace with function body.

# Signal handler for when a body enters the Area2D
func _on_body_entered(body):
	print("Body entered: ", body.name)  # Debugging line
	if body.is_in_group("TinyCreatures"):  # You can assign NPCs to a group
		print("A tiny creature is within reach!")
		var epromptSprite = body.get_node("EPrompt")
		epromptSprite.visible = true
		my_array.append(body)
		

# Signal handler for when a body exits the Area2D
func _on_body_exited(body):
	if body.is_in_group("TinyCreatures"):
		print("A tiny creature has left reach!")
		var epromptSprite = body.get_node("EPrompt")
		epromptSprite.visible = false
		my_array.remove_at(my_array.size()-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	proximity_detector.position = rb2d.position
	
	if(grabbing and Input.is_action_just_pressed("Space")):
		var inverter = 1
		if($PlayerRB2D/CollisionPolygon2D/PlayerSprite.flip_h):
			inverter *= -1
		SpriteRB.linear_velocity = (Vector2.RIGHT*SpriteRB.multiplier*3.0*inverter)+(Vector2.UP*SpriteRB.multiplier*3.0)
		SpriteRB.walking = false
		SpriteRB.projectile = true
		SpriteRB.CoalSpriteAnim2D.animation = &"falling"
		SpriteRB.projectile = true
		SpriteRB.grabbed = false
		SpriteRB.grabbable = false
		SpriteRB = null
		grabbing = false
	
	if(!grabbing and Input.is_action_just_pressed("EKey")):
		if(my_array.size() != 0):
			SpriteRB = my_array[0]
			grabbing = true
		else:
			SpriteRB = null
		
		
	if(grabbing):
		var inverter = 1
		if($PlayerRB2D/CollisionPolygon2D/PlayerSprite.flip_h):
			inverter *= -1
		SpriteRB.playerPos = $PlayerRB2D.global_position+Vector2.UP*50+(Vector2.RIGHT*200*inverter)
		pass
		
	#if(SpriteRB != null):
		#print(SpriteRB.playerPos," ",$PlayerRB2D.global_position)
		
	
	pass
