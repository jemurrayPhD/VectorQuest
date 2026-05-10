extends RefCounted
class_name Vector2Math

static func magnitude(v: Vector2) -> float:
	return v.length()

static func angle_degrees(v: Vector2) -> float:
	return rad_to_deg(v.angle())

static func from_polar(magnitude_value: float, angle_degrees_value: float) -> Vector2:
	var angle_radians: float = deg_to_rad(angle_degrees_value)
	return Vector2(cos(angle_radians), sin(angle_radians)) * magnitude_value

static func dot(a: Vector2, b: Vector2) -> float:
	return a.dot(b)

static func projection_of_a_onto_b(a: Vector2, b: Vector2) -> Vector2:
	if is_zero_approx(b.length_squared()):
		return Vector2.ZERO
	return b * (a.dot(b) / b.length_squared())

static func approx_equal_vec2(a: Vector2, b: Vector2, tolerance: float) -> bool:
	return a.distance_to(b) <= tolerance

static func component_error(a: Vector2, b: Vector2) -> Vector2:
	return a - b

static func distance(a: Vector2, b: Vector2) -> float:
	return a.distance_to(b)
