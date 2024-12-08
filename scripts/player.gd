extends KinematicBody2D

onready var player_bullet_file = preload("res://scenes/bullet.tscn")
onready var score_label = $CanvasLayer/score  
onready var enemy: KinematicBody2D = $"../enemy"

var el = 8.0
var speed = Global.player_speed
var friction = Global.friction
var velocity = Vector2()
var up = Vector2.UP
var bullet
var bullet_speed = 600
var ran = RandomNumberGenerator.new()
var new_speed_i = 200
var new_speed_d = 40
var new_enemy_speed_i = 60
var new_enemy_speed_d = 20
var gravity = 80
var max_gravity = 100 
var damage
var enemy_speed 

func _ready() -> void:
	ran.randomize()
	$Timer.start(10)

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())  
	
	if Input.is_action_just_pressed("shoot"):
		bullet = player_bullet_file.instance()
		bullet.position = global_position  
		bullet.rotation_degrees = rotation_degrees  
		bullet.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(bullet.rotation))  
		get_parent().add_child(bullet)
		$shoot.play()
		score_label.text = str("score ", Global.score)
		$Camera2D/camshake.start()
		$CPUParticles2D.emitting


func _physics_process(delta: float) -> void:
	speed = Global.player_speed
	enemy_speed = Global.enemy_speed
	damage = Global.player_damage
	if Input.is_action_pressed("right"):
		velocity.x = speed
	elif Input.is_action_pressed("left"):
		velocity.x = -speed 
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta)

	if Input.is_action_pressed("down"):
		velocity.y = speed
	elif Input.is_action_pressed("up"):
		velocity.y = -speed
	else:
		velocity.y = lerp(velocity.y, 0, friction * delta)
	
		
	$CanvasLayer/timer.text = str(int($Timer.time_left))
	$CanvasLayer/health.text = str("health ", Global.player_health)
	if Global.player_health <= 30:
		$CanvasLayer/health.add_color_override("font_color",Color("fb0000"))
	else:
		$CanvasLayer/health.add_color_override("font_color",Color("ffffff"))
	velocity = move_and_slide(velocity, up)

func damage_player():
	Global.player_health -= Global.enemy_damage
	$Camera2D/camshake.start()
	if Global.player_health <= 0:
		Global.player_health = 0
		Global.score = 0
		Global.player_speed = 100
		get_tree().change_scene("res://scenes/dead.tscn")


func _on_Timer_timeout() -> void:
	#player buffs
	var renum = ran.randi_range(1,4)
	if renum == 1:
		var rnum = ran.randi_range(0,1)
		if rnum == 0:
			Global.player_speed = new_speed_i
			$CanvasLayer/powerup.text = str("+speed")
			scale.x = 1
			scale.y = 1
#			Global.player_damage = 100
		elif rnum == 1:
			Global.player_speed = new_speed_d
			$CanvasLayer/powerup.text = str("-speed")
			scale.x = 1
			scale.y = 1
#			Global.player_damage = 100
		print(Global.player_speed)
	
	elif renum == 2:
		var rnum = ran.randi_range(0,1)
		if rnum == 0:
			Global.player_health = 50
			$CanvasLayer/powerup.text = str("-health")
			Global.player_speed = 100
#			Global.player_damage = 100
			scale.x = 1
			scale.y = 1

	
		elif rnum == 1:
			$CanvasLayer/powerup.text = str("+health")		
			Global.player_health = 100
			Global.player_speed = 100
#			Global.player_damage = 100
			scale.x = 1
			scale.y = 1
			
	
	elif renum == 3:
		var rnum = ran.randi_range(0,1)
		if renum == 0:
			scale.x = 2
			scale.y = 2
			Global.player_speed = 50
#			Global.player_damage = 100
			
			$CanvasLayer/powerup.text = str("+size")
		elif renum == 1:
			scale.x = 0.5
			scale.y = 0.5
			Global.player_speed = 150
#			Global.player_damage = 100
			
			$CanvasLayer/powerup.text = str("-size")

	elif renum == 4:
		velocity.y -= gravity
		if velocity.y > max_gravity:
			velocity.y = max_gravity 
		$CanvasLayer/powerup.text = str("gravity")
		velocity = move_and_slide(velocity)
		scale.x = 1
		scale.y = 1
		Global.player_speed = 100
#		Global.player_damage = 100
	

	#enemy buffs 
	var erenum = ran.randi_range(1,2)
	if erenum == 1:
		var rnum = ran.randi_range(0,1)
		if rnum == 0:
			Global.enemy_speed = new_enemy_speed_d
			Global.player_damage = 100
			$CanvasLayer/enemy_powerup.text = str("-speed")
		elif rnum == 1:
			Global.enemy_speed = new_enemy_speed_i
			Global.player_damage = 100
			
			$CanvasLayer/enemy_powerup.text = str("+speed")
		print(Global.enemy_speed)

	elif renum == 2:
		Global.player_damage = 50
		Global.enemy_speed = 40
		$CanvasLayer/enemy_powerup.text = str("+health")
		
	$Timer.start()


