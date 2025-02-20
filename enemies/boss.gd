extends Enemy

@export var bob_height : float = 850
@export var bob_speed : float = 1.5

@onready var start_x : float = position.x

var t : float = 0.0

func _ready() -> void:
	speed  = -50

	health  = 2500
	powerup_rate = 1
	enemy_bullet = preload("res://player/weapons/bullet.tscn")

func _process(delta: float) -> void:
	t += delta
	var d = (sin(t * bob_speed) + 1) / 2
	position.x = start_x + (d * bob_height)
	
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
	for n in 8:
		if on_screen:
			shoot_bullet()
			await get_tree().create_timer(0.1).timeout
	
	
