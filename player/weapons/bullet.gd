extends Area2D
class_name Bullet

var speed : float = 1200.0
var damage = 10

var bullet_origin : String

@onready var sprite : Node = get_node("AnimatedSprite2D")
@onready var pop_sound : Node = get_node("pop")

var bullet_spread : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if bullet_origin == "player":
		global_position.y -= speed * delta
	else:
		global_position.y += speed/2 * delta
		
	if bullet_spread == "right":
		global_position.x += speed/2 * delta
		rotation = 10
	elif bullet_spread == "left":
		global_position.x -= speed/2 * delta
		rotation = -10
	else:
		pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player and bullet_origin == "enemy" and !body.dead:
		body.hit(damage)
		sprite.play("enemypop")
		speed = 0
		pop_sound.play()
	else:
		pass


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy and bullet_origin == "player":
		area.hit(damage)
		sprite.play("playerpop")
		speed = 0
		pop_sound.play()
