extends KinematicBody2D
onready var player: KinematicBody2D = $"../player"
onready var timer: Timer = $Timer

var velocity = Vector2()
var ran = RandomNumberGenerator.new()
var speed = Global.enemy_speed
var enemy_health = Global.enemy_health
var renum 
var new_speed_d = 20
var new_speed_i = 50
var enemy_die = false

func _ready() -> void:
	$CanvasModulate.color = Color(255, 255, 255)
	ran.randomize()

func _physics_process(delta: float) -> void:
	speed = Global.enemy_speed
	enemy_health = Global.enemy_health
	velocity = (player.global_position - global_position).normalized() * Global.enemy_speed 
	velocity = move_and_slide(velocity)
	look_at(player.global_position)
	if enemy_die == true:
		$AudioStreamPlayer2D.play()

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("damage_player"):
		body.damage_player()

func bullet_collide():
	$CPUParticles2D.emitting
	enemy_die = true
	Global.enemy_health -= Global.player_damage
	$CanvasModulate.color = Color(0, 0, 0)
	if Global.enemy_health <= 0:
		Global.enemy_health = 0
		Global.enemy_killed = true
		Global.score += 1
		queue_free()


func _on_Area2D2_body_entered(body: Node) -> void:
	if body.has_method("is_it_bullet"):
		body.is_it_bullet()
