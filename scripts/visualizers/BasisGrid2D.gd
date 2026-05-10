extends Control
class_name BasisGrid2D

@export var pixels_per_unit: float = 24.0
@export var grid_extent_units: int = 12

func world_to_screen(v: Vector2) -> Vector2:
	return Vector2(size.x * 0.5 + v.x * pixels_per_unit, size.y * 0.5 - v.y * pixels_per_unit)

func screen_to_world(v: Vector2) -> Vector2:
	return Vector2((v.x - size.x * 0.5) / pixels_per_unit, (size.y * 0.5 - v.y) / pixels_per_unit)

func _draw() -> void:
	var center := Vector2(size.x * 0.5, size.y * 0.5)
	for i in range(-grid_extent_units, grid_extent_units + 1):
		var x := center.x + i * pixels_per_unit
		var y := center.y + i * pixels_per_unit
		draw_line(Vector2(x, 0), Vector2(x, size.y), Color(0.2, 0.2, 0.2), 1.0)
		draw_line(Vector2(0, y), Vector2(size.x, y), Color(0.2, 0.2, 0.2), 1.0)
	draw_line(Vector2(0, center.y), Vector2(size.x, center.y), Color(0.8, 0.8, 0.8), 2.0)
	draw_line(Vector2(center.x, 0), Vector2(center.x, size.y), Color(0.8, 0.8, 0.8), 2.0)
