extends RefCounted
class_name DifficultyManager

const PRESETS := {
	"easy": {"coordinate_range": 8, "integer_only": true, "tolerance": 0.5, "time_limit": 90.0, "allow_polar": true},
	"medium": {"coordinate_range": 12, "integer_only": false, "tolerance": 0.35, "time_limit": 75.0, "allow_polar": true},
	"hard": {"coordinate_range": 16, "integer_only": false, "tolerance": 0.2, "time_limit": 60.0, "allow_polar": false}
}

static func get_preset(name: String) -> Dictionary:
	return PRESETS.get(name, PRESETS["easy"])
