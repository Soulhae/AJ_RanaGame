extends Node
class_name State

# Se emite cuando este estado quiere cambiar a otro.
signal transitioned(state: State, new_state_name: String)

# Al entrar al estado.
func enter():
	pass

# Al salir del estado.
func exit():
	pass

# Actualización por frame.
func process(_delta: float):
	pass

# Actualización de física.
func physics_process(_delta: float):
	pass

# Input no manejado, lo reenvía la máquina de estados.
func _unhandled_input(_event: InputEvent):
	pass
