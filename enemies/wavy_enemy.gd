extends Enemy

@export var bob_height : float = 250
@export var bob_speed : float = 2.5

@onready var start_x : float = position.x

var t : float = 0.0

func _ready() -> void:
	speed  = 20
	powerup_rate = 5
	health  = 30
	homing_chance = 100

func _physics_process(delta: float) -> void:
	if on_screen and !dead:
		position.y += speed * delta
		t += delta
		var d = (sin(t * bob_speed) + 1) / 2
		position.x = start_x + (d * bob_height)

	if can_shoot:
		var b = enemy_bullet.instantiate()
		bullet_storage.add_child(b)
		b.global_position = muzzle.global_position
		b.bullet_origin = "enemy"
		b.sprite.play("enemy")
		can_shoot = false
		shoot_timer.start()
		
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		sprite.offset = randomOffset()
