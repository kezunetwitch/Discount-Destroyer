extends Area2D

#signal stuff
signal level_complete(scene_path)

#variables for what the current level is, what is next and prepares the scene transitions
@onready var level := get_parent()

@export var scene_path : String

#on ready...

#every frame...
func _process(_float) -> void:
	if Input.is_action_just_pressed("shake"):
		level_complete.emit(scene_path)
		
#if the player enters this area, move on to the next level
func _on_body_entered(body: Node) -> void:
	if body is Player:
		level_complete.emit(scene_path)
