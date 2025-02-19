extends Node
class_name jammed_state

var jam_fix : int = 3

@onready var player : Node = get_parent().get_parent()
@onready var sprite : Node = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func reset_node() -> void:
	jam_fix = randi_range(3, 5)
	player.camera.apply_shake(30)
	sprite.play("jammed")

#physics stuff
func _physics_process(_delta: float) -> void:
	#while idle...
	if player.current_state == "jammed":
		if Input.is_action_just_pressed("shoot"):
			player.camera.apply_shake(5)
			jam_fix -= 1
			player.unjam_sound.play()
			if jam_fix <= 0:
				player.can_shoot = true
				sprite.play("default")
				player.jam_buffer = 10
				player.change_state("move")
	
		player.velocity.x = lerp(player.velocity.x , 0.0 , player.jam_friction)
		player.velocity.y = lerp(player.velocity.y , 0.0 , player.jam_friction)
		player.position.x = clamp(player.position.x, 30, player.screensize.x-30)
		player.position.y = clamp(player.position.y, 30+player.camera.position.y, player.screensize.y-30+player.camera.position.y)
