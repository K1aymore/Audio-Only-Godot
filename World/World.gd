extends Node2D

const FADE_SPEED = 10  # dB/sec

const WORLDBUS = 1
var worldVolume

var state = "entering"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	worldVolume = AudioServer.get_bus_volume_db(WORLDBUS)
	if state == "dead":
		AudioServer.set_bus_volume_db(WORLDBUS, worldVolume - (FADE_SPEED*delta))
		#if worldVolume <= -40:
			#get_tree().quit()
	
	elif state == "entering":
		AudioServer.set_bus_volume_db(WORLDBUS, worldVolume + (FADE_SPEED*delta))
		if worldVolume >= 0:
			state == "inGame"
			AudioServer.set_bus_volume_db(WORLDBUS, 0)
	
	elif state == "winning":
		AudioServer.set_bus_volume_db(WORLDBUS, worldVolume - (FADE_SPEED*delta))
		if worldVolume <= -30:
			state = "entering"
			AudioServer.set_bus_volume_db(WORLDBUS, -15)


func _on_Exit_body_entered(body):
	if body.is_in_group("player"):
		win()


func win():
	$"Door Open".play()
	state = "winning"
	stop()


func stop():
	get_tree().call_group("enemies", "stop")


func _on_Zombie_kill():
	if state != "dead":
		$DeathThud.play()
		$DeathBreath.play()
		state = "dead";
		stop()
