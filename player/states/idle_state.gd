extends Node
class_name idle_state

@onready var player : Node = get_parent().get_parent()
@onready var sprite : Node = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func reset_node() -> void:
	player.can_shoot = true
	sprite.play("default")

#physics stuff
func _physics_process(_delta: float) -> void:
	#while idle...
	if player.current_state == "idle":
		if Input.is_action_pressed("shoot") and player.can_shoot:
			player.shoot()
		if Input.is_action_pressed("bomb") and player.can_bomb:
			player.launch_bomb()
		#if the player moves, switch them to the move state
		if Input.is_action_pressed("move_right"):
			player.change_state("move")
		elif Input.is_action_pressed("move_left"):
			player.change_state("move")
		if Input.is_action_pressed("move_up"):
			player.change_state("move")
		elif Input.is_action_pressed("move_down"):
			player.change_state("move")
			
		player.velocity.x = lerp(player.velocity.x , 0.0 , player.friction)
		player.velocity.y = lerp(player.velocity.y , 0.0 , player.friction)
		player.position.x = clamp(player.position.x, 30, player.screensize.x-30)
		player.position.y = clamp(player.position.y, 30+player.camera.position.y, player.screensize.y-30+player.camera.position.y)
