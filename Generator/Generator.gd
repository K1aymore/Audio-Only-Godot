extends Area2D

var on = false

signal turnOn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Generator_body_entered(body):
	if body.is_in_group("player") && !on:
		on = true
		$Humming.stop()
		$Switch.play()
		emit_signal("turnOn")
