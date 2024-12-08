extends RigidBody2D


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("bullet_collide"):
		body.bullet_collide()

func bullet_gone():
	queue_free()

func bullet_gone_2():
	queue_free()

func is_it_bullet():
	$AudioStreamPlayer2D.play()
	
