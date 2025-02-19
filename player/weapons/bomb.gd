extends Area2D
class_name Bomb

var speed = 200

var current_state : String = "fired"
var bullet_origin : String

@onready var sprite : Node = get_node("AnimatedSprite2D")
@onready var bullet_target : Node = get_node("CollisionShape2D")

@onready var bullet_storage : Node = get_parent()

var dud_chance : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	dud_chance = randi_range(1, 10)
	if dud_chance <= 1:
		print("dud")
		bullet_target.disabled = false
		change_state("dud")
	else:
		change_state("boom")
		

func change_state(new_state_name: String) -> void:
	current_state = new_state_name
	print(current_state)
	for i in get_node("States").get_child_count():
		if new_state_name in get_node("States").get_child(i).name:
			get_node("States").get_child(i).reset_node()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet or area is Bomb:
		if area.bullet_origin == "player":
			change_state("boom")
		else:
			print("no boom")
	else:
		pass
