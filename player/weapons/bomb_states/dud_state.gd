extends Node
class_name dud_state

@onready var bomb = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.

func reset_node():
	bomb.sprite.play("dud")
	
func _physics_process(delta: float) -> void:
	if bomb.current_state == "dud":
		pass
