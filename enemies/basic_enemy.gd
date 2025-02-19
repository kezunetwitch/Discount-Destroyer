extends Area2D
class_name Enemy

var speed : int = 30

var health : int = 50
var dead : bool = false

var on_screen : bool
var can_shoot : bool

var powerup_rate : int = 10

@onready var enemy_bullet : PackedScene = preload("res://player/weapons/bullet.tscn")
@onready var bullet_storage : Node = get_parent().get_parent().get_node("Bullets")
@onready var muzzle : Node = get_node("muzzle")
@onready var shoot_timer : Node = get_node("shoot_timer")
@onready var collider : Node = get_node("CollisionShape2D")

@onready var powerup_storage : Node = get_parent().get_parent().get_node("Powerups")

@onready var powerup_instance : PackedScene = preload("res://powerups/powerup_base.tscn")

@export var random_strength: float = 10.0
@export var shakeFade: float = 5.0

@onready var sprite : Node = get_node("AnimatedSprite2D")

@onready var die_sound : Node = get_node("pop")

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0


func _process(delta: float) -> void:
	if can_shoot:
		shoot_bullet()
		can_shoot = false
		shoot_timer.start()
		
	if on_screen:
		position.y += speed * delta
	else:
		can_shoot = false

	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		sprite.offset = randomOffset()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	on_screen = true

func _on_shoot_timer_timeout() -> void:
	can_shoot = true

func _on_shoot_vissy_screen_entered() -> void:
	can_shoot = true

func hit(value) -> void:
	health -= value
	apply_shake(5)
	if health <= 0 and dead == false:
		var pos = muzzle.global_position
		make_powerup(pos)
		await get_tree().create_timer(.01).timeout
		position.x = -150
		dead = true
		die()

func apply_shake(random_strength):
	shake_strength = random_strength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _on_pop_finished() -> void:
	queue_free()

func make_powerup(pos) -> void:
	if randi_range(1, powerup_rate) == 1:
		var p = powerup_instance.instantiate()
		powerup_storage.add_child(p)
		p.global_position = pos
		p.select = randi_range(1,4)

func die() -> void:
	if on_screen:
		die_sound.play()
		can_shoot = false
		shoot_timer.stop()
		sprite.visible = false
		await get_tree().create_timer(.01).timeout
		position.x = -100

func shoot_bullet() -> void:
	if on_screen == true:
		var b = enemy_bullet.instantiate()
		bullet_storage.add_child(b)
		b.global_position = muzzle.global_position
		b.bullet_origin = "enemy"
		b.sprite.play("enemy")
