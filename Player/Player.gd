extends KinematicBody2D

const SPEED = 150


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	velocity.x = Input.get_axis("ui_left", "ui_right")
	velocity.y = Input.get_axis("ui_up", "ui_down")
	
	velocity = move_and_slide(velocity * SPEED)
	
	$Footsteps.stream_paused = velocity == Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_accept"):
		$Cover.visible = !$Cover.visible
	
