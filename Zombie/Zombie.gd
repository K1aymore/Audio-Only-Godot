extends KinematicBody2D

const SPEED = 75

var velocity
var player
var walking = true


signal kill

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


func _physics_process(delta):
	if walking:
		velocity = self.position.direction_to(player.position)
	
	velocity = move_and_slide(velocity * SPEED)
	
	$Walk.stream_paused = velocity == Vector2.ZERO
	
	velocity = Vector2.ZERO
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider == player:
			emit_signal("kill")


func stop():
	walking = false
