extends Area2D
class_name HMissile

var speed : float = 200.0
var damage = 5

var bullet_origin : String

@onready var sprite : Node = get_node("Sprite2D")
@onready var pop_sound : Node = get_node("pop")
@onready var target : Node = get_parent().get_parent().get_node("Player")

var bullet_spread : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = target.position - position
	direction = direction.normalized()
	
	var rotamount = direction.cross(transform.y)
	
	rotate(rotamount * 2.5 * delta)
	
	global_translate(-transform.y * speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player and bullet_origin == "enemy" and !body.dead:
		body.hit(damage)
		sprite.visible = false
		speed = 0
		pop_sound.play()
	else:
		pass



func _on_area_entered(area: Area2D) -> void:
	if area is Bullet and area.bullet_origin == "player":
		speed = 0
		sprite.visible = false
		pop_sound.play()


func _on_pop_finished() -> void:
	queue_free()
