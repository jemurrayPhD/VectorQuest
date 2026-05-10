extends RefCounted
class_name CoordinateSystems

static func cartesian_to_polar(v: Vector2) -> Dictionary:
	return {
		"magnitude": v.length(),
		"angle_degrees": normalize_angle_degrees(rad_to_deg(v.angle()))
	}

static func polar_to_cartesian(magnitude_value: float, angle_degrees_value: float) -> Vector2:
	var radians_value: float = deg_to_rad(angle_degrees_value)
	return Vector2(cos(radians_value), sin(radians_value)) * magnitude_value

static func normalize_angle_degrees(angle: float) -> float:
	var normalized: float = fmod(angle, 360.0)
	if normalized < 0.0:
		normalized += 360.0
	return normalized
