extends Area2D

@onready var player : Node = get_parent()
@onready var sprite : Node = get_node("AnimatedSprite2D")

@onready var collider : Node = get_node("CollisionShape2D")

var shield_health : int = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("full")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet and area.bullet_origin == "enemy" and shield_health != 0:
		damage_shield()
		area.queue_free()
	if area is Enemy and shield_health != 0:
		area.die()
		shield_health = 1
		damage_shield()

func damage_shield() -> void:
	shield_health -= 1
	if shield_health <= 0:
		sprite.play("charging")
		collider.set_deferred("disabled", true)
		await get_tree().create_timer(10).timeout
		shield_reset()
		
	elif shield_health == 2:
		sprite.play("half")
	elif shield_health == 1:
		sprite.play("weak")
	else:
		sprite.play("full")

func shield_reset() -> void:
	collider.set_deferred("disabled", false)
	shield_health = 3
	sprite.play("full")
