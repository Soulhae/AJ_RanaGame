class_name PlayerController
extends Node3D

@export var tejo_scene: PackedScene

# Ajustes de apuntado
@export var aim_speed: float = 1.2
@export var aim_min_deg: float = -45.0
@export var aim_max_deg: float = 45.0

# Ajustes de potencia
@export var max_power: float = 25.0
@export var power_speed: float = 16.0
@export var arc_factor: float = 0.3

# Movimiento de la mano en pantalla
@export var hand_min_x: float = -180.0
@export var hand_max_x: float = 180.0
@export var hand_half_width: float = 250.0

signal tejo_lanzado(direction: Vector3, power: float)

var aim_value: float = 0.0
var aim_direction: int = 1
var aim_angle: float = 0.0
var power_value: float = 0.0
var power_direction: int = 1
var throws_remaining: int = -1  # -1 = sin límite

@onready var throw_marker: Marker3D = %ThrowMarker
@onready var hand: Control = %Hand
@onready var power_bar: ProgressBar = %PowerBar


func _ready() -> void:
	power_bar.max_value = max_power
	power_bar.value = 0.0


func set_throws_remaining(n: int) -> void:
	throws_remaining = n


func has_throws() -> bool:
	return throws_remaining < 0 or throws_remaining > 0


func consume_throw() -> void:
	if throws_remaining > 0:
		throws_remaining -= 1


func get_throw_direction() -> Vector3:
	return Vector3.FORWARD.rotated(Vector3.UP, deg_to_rad(-aim_angle))


func spawn_tejo() -> RigidBody3D:
	var tejo: RigidBody3D = tejo_scene.instantiate()
	get_parent().add_child(tejo)
	tejo.global_position = throw_marker.global_position
	var impulse := get_throw_direction() * power_value + Vector3.UP * power_value * arc_factor
	tejo.apply_central_impulse(impulse)
	return tejo


func reset_throw() -> void:
	aim_value = 0.0
	aim_direction = 1
	power_value = 0.0
	power_direction = 1


func update_hand() -> void:
	aim_angle = lerpf(aim_min_deg, aim_max_deg, aim_value)
	if hand:
		var shift := lerpf(hand_min_x, hand_max_x, aim_value)
		hand.offset_left = -hand_half_width + shift
		hand.offset_right = hand_half_width + shift


func update_power_bar() -> void:
	if power_bar:
		power_bar.value = power_value
