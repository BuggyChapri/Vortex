extends Control



func _ready() -> void:
	$AudioStreamPlayer.play()

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://scenes/main.tscn")
	Global.player_health = 100

func _on_Button2_pressed() -> void:
	get_tree().quit()
