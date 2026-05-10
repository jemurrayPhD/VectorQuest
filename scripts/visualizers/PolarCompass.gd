extends Control
class_name PolarCompass

@export var angle_degrees: float = 0.0

func _draw() -> void:
	var center := size * 0.5
	var radius := min(size.x, size.y) * 0.4
	draw_circle(center, radius, Color(0.1, 0.1, 0.1), false, 2.0)
	var dir := Vector2.RIGHT.rotated(deg_to_rad(-angle_degrees))
	draw_line(center, center + dir * radius, Color.GOLD, 2.0)
