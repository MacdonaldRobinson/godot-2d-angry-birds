extends RigidBody2D

func _on_Bird_body_entered(body):
	yield(get_tree().create_timer(5),"timeout")
	get_tree().reload_current_scene()
