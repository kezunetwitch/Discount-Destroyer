extends Node

#signal stuff
signal level_complete(scene_path)

@onready var main_menu = preload("res://main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene = main_menu.instantiate()
	add_child(scene)
	var start_button = scene.get_node("MenuBody/Start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func remove_old_level(scene_path):
	#remove the old level
	for i in get_child_count():
		var child = get_child(i)
		child.queue_free()
		call_deferred("remove_child",child)

	#loads in the new scene
	print(scene_path)
	var new_scene = load(scene_path)
	print(new_scene)
	var ns = new_scene.instantiate()
	
	call_deferred("add_child",ns)
	
	#connects to level script
	ns.connect("level_complete", remove_old_level)
	var level_completer = ns.get_node("level_completer")
	#connect signal
	level_completer.connect("level_complete", remove_old_level)

	
	#after a few seconds, delete transition square
	await get_tree().create_timer(3).timeout
