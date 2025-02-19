extends Node
class_name boom_state

@onready var bomb = get_parent().get_parent()
@onready var explosion : PackedScene = preload("res://player/weapons/explosion.tscn")
# Called when the node enters the scene tree for the first time.

func reset_node():
	bomb.sprite.visible = false
	var e = explosion.instantiate()
	bomb.bullet_storage.add_child(e)
	e.global_position = bomb.global_position
	bomb.queue_free()
