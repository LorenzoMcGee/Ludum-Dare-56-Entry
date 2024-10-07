extends AnimatedSprite2D

var done = false
var doorObj
var doorColl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	doorObj = get_tree().get_nodes_in_group("Door")[0]
	doorColl = get_tree().get_nodes_in_group("DoorCollide")[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(not done and animation == &"on"):
		done = true
		doorObj.animation = &"new_animation"
		doorObj.play()
		doorColl.disabled = true
	pass
