extends Node2D

@onready var pause_menu := $PauseMenu

var master_bus = AudioServer.get_bus_index("Master")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		get_tree().paused = true
		show_pause_menu()

func show_pause_menu() -> void:
	pause_menu.visible = true

func hide_pause_menu() -> void:
	pause_menu.visible = false

func _on_resume_pressed() -> void:
	hide_pause_menu()
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()
