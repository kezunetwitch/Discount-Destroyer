extends Bullet

var direction: Vector2

@onready var player : Node = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 300
	damage = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if position.y <= player.position.y:
		look_at(player.position)
		if position.distance_to(player.position) < 150:
			global_position.x -= (global_position.x - player.position.x) * delta*10
		else:
			global_position.x -= (global_position.x - player.position.x) * delta*1.5
	else:
		sprite.rotation = 0
	
	
	
	position.y += speed * delta
