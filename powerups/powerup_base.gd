extends Area2D

@onready var sprite : Node = $AnimatedSprite2D
var select : int = randi_range(1,4)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.visible = true
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
	elif select == 4:
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
