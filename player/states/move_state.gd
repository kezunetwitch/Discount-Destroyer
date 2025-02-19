extends Node
class_name move_state

@onready var player : Node = get_parent().get_parent()
@onready var sprite : Node = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func reset_node():
	player.can_shoot = true
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player.current_state == "move":
		if Input.is_action_pressed("shoot") and player.can_shoot:
			player.shoot()
		if Input.is_action_pressed("bomb") and player.can_bomb:
			player.launch_bomb()
		if Input.is_action_pressed("move_right"):
			var target_vel : float = min(player.velocity.x + player.acceleration * delta, player.max_speed+500 * delta)
			player.velocity.x = lerp(player.velocity.x, target_vel, player.weight)
		elif Input.is_action_pressed("move_left"):
			var target_vel : float = max(player.velocity.x + player.acceleration * -delta, -player.max_speed+500 * delta)
			player.velocity.x = lerp(player.velocity.x, target_vel, player.weight)
		if Input.is_action_pressed("move_up"):
			var target_vel : float = min(player.velocity.y + player.acceleration * -delta, player.max_speed * delta)
			player.velocity.y = lerp(player.velocity.y, target_vel, player.weight)
		elif Input.is_action_pressed("move_down"):
			var target_vel : float = max(player.velocity.y + player.acceleration * delta, -player.max_speed * delta)
			player.velocity.y = lerp(player.velocity.y, target_vel, player.weight)
		
		player.velocity.x = lerp(player.velocity.x , 0.0 , player.friction)
		player.velocity.y = lerp(player.velocity.y , 0.0 , player.friction)
		player.position.x = clamp(player.position.x, 30, player.screensize.x-30)
		player.position.y = clamp(player.position.y, 30+player.camera.position.y, player.screensize.y-30+player.camera.position.y)
	
