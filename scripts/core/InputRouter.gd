extends Node
class_name InputRouter

signal submit_pressed

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		emit_signal("submit_pressed")
