class_name PlayerAiming
extends State

@onready var controller: PlayerController = get_parent().get_parent()


func enter() -> void:
	controller.reset_throw()
	controller.update_hand()


func process(delta: float) -> void:
	if not controller.has_throws():
		transitioned.emit(self, "player_idle")
		return

	# La mira oscila de un lado al otro.
	controller.aim_value += controller.aim_speed * delta * controller.aim_direction
	if controller.aim_value >= 1.0:
		controller.aim_value = 1.0
		controller.aim_direction = -1
	elif controller.aim_value <= 0.0:
		controller.aim_value = 0.0
		controller.aim_direction = 1

	controller.update_hand()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		transitioned.emit(self, "player_power")
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_SPACE:
		transitioned.emit(self, "player_power")
