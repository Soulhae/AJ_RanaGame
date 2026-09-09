class_name PlayerRelease
extends State

@onready var controller: PlayerController = get_parent().get_parent()


func enter() -> void:
	controller.consume_throw()
	var direction: Vector3 = controller.get_throw_direction()
	var power: float = controller.power_value
	controller.spawn_tejo()
	controller.tejo_lanzado.emit(direction, power)

	# Si quedan tejos, se puede volver a apuntar enseguida.
	if controller.has_throws():
		transitioned.emit(self, "player_aiming")
	else:
		transitioned.emit(self, "player_idle")
