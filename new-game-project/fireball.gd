extends AnimatedSprite2D

var speed = 400  # Speed of the projectile
var direction
var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction.normalized() * speed



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	if position.y < -100 or position.y > 1000:  # Example of destroying when out of bounds
		queue_free()

func set_direction(new_direction: Vector2):
	direction = new_direction
	rotation = atan(direction.y/direction.x)

func _on_body_entered(body):
	#print("Body entered: ", body.name)  # Debugging line
	if not body.is_in_group("TinyCreatures"):  # You can assign NPCs to a group
		queue_free()
	
		
