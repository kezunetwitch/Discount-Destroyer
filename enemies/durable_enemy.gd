extends Enemy


func _ready() -> void:
	speed  = 20

	health  = 200
	
	enemy_bullet = preload("res://player/weapons/bullet.tscn")

func _process(delta: float) -> void:
	if can_shoot:
		durable_shot()
		can_shoot = false
		shoot_timer.start()
		
	if on_screen:
		position.y += speed * delta

	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		sprite.offset = randomOffset()
		
func durable_shot() -> void:
	for n in 3:
		if on_screen:
			shoot_bullet()
			await get_tree().create_timer(0.2).timeout
	
	
