extends Control
class_name VectorArrow2D

@export var start_point: Vector2 = Vector2.ZERO
@export var end_point: Vector2 = Vector2(100, -60)
@export var arrow_color: Color = Color.CYAN
@export var label: String = "v"
@export var thickness: float = 3.0
@export var arrowhead_size: float = 10.0
@export var draw_components: bool = false

func set_points(start_value: Vector2, end_value: Vector2) -> void:
	start_point = start_value
	end_point = end_value
	queue_redraw()

func _draw() -> void:
	draw_line(start_point, end_point, arrow_color, thickness)
	var direction := (end_point - start_point).normalized()
	if direction.length() > 0.0:
		var left := end_point - direction * arrowhead_size + Vector2(-direction.y, direction.x) * arrowhead_size * 0.6
		var right := end_point - direction * arrowhead_size + Vector2(direction.y, -direction.x) * arrowhead_size * 0.6
		draw_line(end_point, left, arrow_color, thickness)
		draw_line(end_point, right, arrow_color, thickness)
	if draw_components:
		var leg_point := Vector2(end_point.x, start_point.y)
		draw_line(start_point, leg_point, Color(1.0, 0.5, 0.2), 2.0)
		draw_line(leg_point, end_point, Color(0.3, 1.0, 0.4), 2.0)
	draw_string(get_theme_default_font(), end_point + Vector2(8, -8), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, arrow_color)
