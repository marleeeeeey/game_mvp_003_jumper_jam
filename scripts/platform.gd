extends Area2D

func _on_body_entered(body):
	if body is Player:
		
		# If player goes down then it should jump on touch with platform.
		if body.velocity.y > 0:
			body.jump()
