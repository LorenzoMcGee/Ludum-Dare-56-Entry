extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_Area2D_body_entered(body):
	#print("Body entered: ", body.name)  # Debugging line
	if body.is_in_group("RequireFlame"):  # You can assign NPCs to a group
		#print("A tiny creature is within reach!")
		print(typeof(body))
		var candleobject = body
		print(typeof(body)," REQUIREFLAME")
