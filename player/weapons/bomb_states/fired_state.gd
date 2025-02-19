extends Node
class_name fired_state

@onready var bomb = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.

func reset_node():
	bomb.sprite.play("fired")
	
func _physics_process(delta: float) -> void:
	if bomb.current_state == "fired":
		bomb.position.y -= bomb.speed * delta
