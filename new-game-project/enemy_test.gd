extends CharacterBody2D

@export var speed = 100  # Speed at which the enemy moves
@export var detection_radius = 300  # How close the player has to be for the enemy to chase

var move_velocity = Vector2.ZERO  # The velocity of the enemy
var player : Node2D = null  # This will store the player reference

func _ready():
	# Look for the player in the scene tree when the enemy is ready
	# Assuming the player is called "Player" and exists in the same scene
	player = get_parent().get_node_or_null("Player")
	
	# Set up the collision shape (adjust according to your enemy's size)
	var collision_shape = $CollisionShape2D.shape
	collision_shape.radius = 20  # Example radius for circle shape

func _process(delta):
	if player and is_instance_valid(player):
		var distance_to_player = position.distance_to(player.position)

		if distance_to_player < detection_radius:
			# Chase the player if within detection range
			var direction = (player.position - position).normalized()
			move_velocity = direction * speed
		else:
			# Optional wandering behavior (random movement)
			wander_around()
	else:
		move_velocity = Vector2.ZERO

	# Move the enemy using the updated velocity
	move_and_collide(move_velocity * delta)

# Optional wandering logic
func wander_around():
	# Implement simple wandering behavior if no player is nearby
	# For example, random movement every few seconds
	if randf() < 0.01:  # 1% chance every frame to change direction
		var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		move_velocity = random_direction * speed * 0.5  # Slower wandering movement
