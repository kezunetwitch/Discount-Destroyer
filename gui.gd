extends CanvasLayer

@onready var health_bar := $Health
@onready var bomb_display := $Bombs
@onready var jam_notif := $JammedNotifier

@onready var player := $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar.text = str("Health ",player.health,"/100")
	bomb_display.text = str("Bombs x ",player.bomb_ammo)
	if player.current_state == "jammed":
		jam_notif.visible = true
	else:
		jam_notif.visible = false
