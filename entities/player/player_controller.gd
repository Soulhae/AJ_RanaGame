extends Node3D

@export var tejo_scene: PackedScene

var throw_direction: Vector3 = Vector3.FORWARD
var throw_power: float = 0.0
var max_power: float = 25.0

@onready var throw_marker: Marker3D = %ThrowMarker
