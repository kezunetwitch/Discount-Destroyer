extends Area2D

@onready var sprite : Node = $AnimatedSprite2D
@export var preset : bool = false
@export var select : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.visible = true
	if !preset:
		select = randi_range(1,4)
	set_powerup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_powerup() -> void:
	if select == 1:
		#bomb
		sprite.play("bomb")
	elif select == 2:
		#shield
		sprite.play("shield")
	elif select == 3:
		#health
		sprite.play("energy")
	else:
		#spread
		sprite.play("spread")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if select == 1:
			body.bomb_ammo += 1
		elif select == 2:
			body.shield.shield_reset()
		elif select == 3:
			body.health += 20
			if body.health >= 100:
				body.health = 100
		elif select == 4:
			body.spread_shot_enable()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
