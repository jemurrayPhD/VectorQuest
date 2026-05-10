extends RefCounted
class_name Problem

var id: String
var prompt: String
var type: String
var given_vectors: Array[Vector2] = []
var target_vector: Vector2
var answer_mode: String
var tolerance: float
var difficulty: String
var tags: Array[String] = []

static func from_dict(data: Dictionary) -> Problem:
	var problem := Problem.new()
	problem.id = str(data.get("id", ""))
	problem.prompt = str(data.get("prompt", ""))
	problem.type = str(data.get("type", ""))
	for v in data.get("given_vectors", []):
		problem.given_vectors.append(Vector2(float(v.get("x", 0.0)), float(v.get("y", 0.0))))
	var target: Dictionary = data.get("target_vector", {"x": 0.0, "y": 0.0})
	problem.target_vector = Vector2(float(target.get("x", 0.0)), float(target.get("y", 0.0)))
	problem.answer_mode = str(data.get("answer_mode", "cartesian"))
	problem.tolerance = float(data.get("tolerance", 0.1))
	problem.difficulty = str(data.get("difficulty", "easy"))
	for tag in data.get("tags", []):
		problem.tags.append(str(tag))
	return problem
