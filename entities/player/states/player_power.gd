class_name PlayerPower
extends State

@onready var controller: PlayerController = get_parent().get_parent()


func enter() -> void:
	# Siempre arranca desde el mínimo.
	controller.power_value = 0.0
	controller.power_direction = 1
	controller.update_power_bar()


func process(delta: float) -> void:
	# La barra sube y baja entre 0 y el máximo.
	controller.power_value += controller.power_speed * delta * controller.power_direction
	if controller.power_value >= controller.max_power:
		controller.power_value = controller.max_power
		controller.power_direction = -1
	elif controller.power_value <= 0.0:
		controller.power_value = 0.0
		controller.power_direction = 1

	controller.update_power_bar()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		transitioned.emit(self, "player_release")
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_SPACE:
		transitioned.emit(self, "player_release")
