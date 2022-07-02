extends RigidBody2D

onready var animations:AnimatedSprite = $AnimatedSprite
onready var impact_sound: AudioStreamPlayer = $ImpactSound
var played_impact_sound: bool = false

func _on_Bird_body_entered(body):
	animations.play("dead")
	
	if !played_impact_sound:
		impact_sound.play()	
		
	yield(get_tree().create_timer(5),"timeout")
	get_tree().reload_current_scene()

func _on_ImpactSound_finished():
	played_impact_sound = true
