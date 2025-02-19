extends CharacterBody2D
class_name Player

var screensize

var max_speed : int = 16000
var acceleration : int = 6000
var direction : int = 0

var health : int = 100
var dead : bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var friction : float = 0.1
var jam_friction : float = 0.01
var weight : float = 0.3

var current_state : String = "idle"
var can_shoot : bool = true
var can_bomb : bool = true
var jam_buffer : int = 10

@onready var bullet_storage : Node = get_parent().get_node("Bullets")
@onready var bullet : PackedScene = preload("res://player/weapons/bullet.tscn")
@onready var shoot_timer : Node = get_node("shoot_timer")
@onready var bomb_timer : Node = get_node("bomb_timer")
@onready var muzzle : Node = get_node("muzzle")
@onready var shield : Node = get_node("Shield")

var spread_shot : bool = false
@onready var spread_timer : Node = get_node("spread_timer")

@onready var shoot_sound : Node = get_node("Audio/shoot")
@onready var unjam_sound : Node = get_node("Audio/unjam")
@onready var die_sound : Node = get_node("Audio/pop")

var bomb_ammo : int = 5
@onready var bomb : PackedScene = preload("res://player/weapons/bomb.tscn")

@onready var camera : Node = get_parent().get_node("Camera2D")

@onready var sprite : Node = get_node("AnimatedSprite2D")

func _ready() -> void:
	screensize = get_viewport_rect().size
	sprite.play("default")

func shoot() -> void:
	jam_buffer -= 1
	shoot_sound.play()
	var b = bullet.instantiate()
	bullet_storage.add_child(b)
	b.bullet_origin = "player"
	b.sprite.play("player")
	b.global_position = muzzle.global_position
	if spread_shot:
		var spread_jam = randi_range(1,3)
		if spread_jam == 1:
			pass
		else:
			b = bullet.instantiate()
			bullet_storage.add_child(b)
			b.bullet_origin = "player"
			b.sprite.play("player")
			b.global_position = muzzle.global_position
			b.bullet_spread = "right"
			b = bullet.instantiate()
			bullet_storage.add_child(b)
			b.bullet_origin = "player"
			b.sprite.play("player")
			b.global_position = muzzle.global_position
			b.bullet_spread = "left"
	can_shoot = false
	var jammed = jam_checker()
	if !jammed:
		shoot_timer.start()
	else:
		change_state("jammed")
		
func launch_bomb() -> void:
	if bomb_ammo > 0:
		var b = bomb.instantiate()
		bullet_storage.add_child(b)
		b.global_position = muzzle.global_position
		b.bullet_origin = "player"
		print("bomb")
		can_bomb = false
		bomb_ammo -= 1
		bomb_timer.start()

func _process(delta: float) -> void:
	screensize = get_viewport_rect().size
	
func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()

func jam_checker() -> bool:
	var jam = randi_range(1, 70)
	if jam <= 1 and jam_buffer <= 0:
		print("JAMMED")
		return true
	else:
		return false
	

func change_state(new_state_name: String) -> void:
	current_state = new_state_name
	print(current_state)
	for i in get_node("States").get_child_count():
		if new_state_name in get_node("States").get_child(i).name:
			get_node("States").get_child(i).reset_node()


func _on_shoot_timer_timeout() -> void:
	can_shoot = true


func _on_bomb_timer_timeout() -> void:
	can_bomb = true

func hit(value) -> void:
	health -= value
	if health <= 0:
		die()
	else:
		camera.apply_shake(10)
		

func spread_shot_enable() -> void:
	spread_shot = true
	spread_timer.start()

func _on_shield_body_entered(body: Node2D) -> void:
	if body is Enemy:
		shield.shield_health = 1
		shield.damage_shield()
		body.die()


func die() -> void:
	dead = true
	max_speed = 0
	can_bomb = false
	can_shoot = false
	camera.apply_shake(100)
	sprite.play("death")
	die_sound.play()
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()


func _on_player_body_area_entered(area: Area2D) -> void:
	if area is Enemy:
		die()


func _on_spread_timer_timeout() -> void:
	spread_shot = false
