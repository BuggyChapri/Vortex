extends Node2D

onready var player_file = preload("res://scenes/player.tscn")
onready var enemy_file = preload("res://scenes/enemy1.tscn")

var player
var enemy

var ran = RandomNumberGenerator.new()

func _ready() -> void:
	ran.randomize()
	$Timer.start()
	$Position2D/CPUParticles2D.emitting = false
	$Position2D2/CPUParticles2D.emitting = false
	$Position2D3/CPUParticles2D.emitting = false
	$Position2D4/CPUParticles2D.emitting = false
	$AudioStreamPlayer.play()


func _on_Timer_timeout() -> void:
	enemy = enemy_file.instance()
	add_child(enemy)
	
	var ran_store = ran.randi_range(1, 4)
	
	if ran_store == 1:
		enemy.global_position = $Position2D.global_position
		$Position2D/CPUParticles2D.emitting = true
		$Position2D2/CPUParticles2D.emitting = false
		$Position2D3/CPUParticles2D.emitting = false
		$Position2D4/CPUParticles2D.emitting = false
	elif ran_store == 2:
		enemy.global_position = $Position2D2.global_position
		$Position2D/CPUParticles2D.emitting = false
		$Position2D2/CPUParticles2D.emitting = true
		$Position2D3/CPUParticles2D.emitting = false
		$Position2D4/CPUParticles2D.emitting = false
	elif ran_store == 3:
		$Position2D/CPUParticles2D.emitting = false
		$Position2D2/CPUParticles2D.emitting = false
		$Position2D3/CPUParticles2D.emitting = true
		$Position2D4/CPUParticles2D.emitting = false
		enemy.global_position = $Position2D3.global_position
	elif ran_store == 4:
		$Position2D/CPUParticles2D.emitting = false
		$Position2D2/CPUParticles2D.emitting = false
		$Position2D3/CPUParticles2D.emitting = false
		$Position2D4/CPUParticles2D.emitting = true
		enemy.global_position = $Position2D4.global_position


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("bullet_gone"):
		body.bullet_gone()


func _on_Area2D2_body_entered(body: Node) -> void:
	if body.has_method("bullet_gone_2"):
		body.bullet_gone_2()
