extends Node
class_name StateMachine

# Estado con el que arranca la máquina.
@export var initial_state: State = null

# Estado activo.
var current_state: State = null

# Guarda todos los estados hijos por nombre.
var states: Dictionary = {}

func _ready() -> void:
	# Registra todos los estados hijos.
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
			# Solo la máquina reenvía el input; los hijos no lo reciben del motor.
			child.set_process_unhandled_input(false)

	# Arranca en el estado inicial.
	if initial_state:
		current_state = initial_state
		initial_state.enter.call_deferred()


func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)


# Reenvía el input al estado actual.
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state._unhandled_input(event)


# Cambia de estado.
func on_child_transitioned(state, new_state_name):

	if state != current_state:
		return

	var new_state = states[new_state_name.to_lower()]

	# Sal del estado anterior.
	var old_state = current_state
	if old_state:
		old_state.exit()

	# Entra al nuevo.
	current_state = new_state
	new_state.enter()
