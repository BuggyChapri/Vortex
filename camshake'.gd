extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0

onready var camera = get_parent()
var priority = 0

	
func start(duration = 0.05 , frequency = 3 , amplitude = 25 ,priority = 0):
	if priority >= self.priority:
		self.priority = priority
		self.amplitude = amplitude
		$Duration.wait_time = duration
		$Frequency.wait_time = 1/ float(frequency)
		$Duration.start()
		$Frequency.start()
		_new_shake()
		
func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude,amplitude)
	rand.y =  rand_range(-amplitude,amplitude)
	
	$ShakeTwen.interpolate_property(camera,"offset",camera.offset,rand,$Frequency.wait_time,TRANS,EASE)
	$ShakeTwen.start()
func _reset():
	$ShakeTwen.interpolate_property(camera ,"offset",camera.offset,Vector2(),$Frequency.wait_time,TRANS,EASE)
	$ShakeTwen.start()
	priority = 0
func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	$Frequency.stop()
