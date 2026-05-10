extends RefCounted
class_name ProblemLoader

static func load_problem_bank(path: String) -> Array[Problem]:
	if not FileAccess.file_exists(path):
		push_error("Problem file does not exist: %s" % path)
		return []
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open problem file: %s" % path)
		return []
	var text: String = file.get_as_text()
	var json := JSON.new()
	var parse_result: int = json.parse(text)
	if parse_result != OK:
		push_error("JSON parse error at line %d in %s: %s" % [json.get_error_line(), path, json.get_error_message()])
		return []
	var root = json.data
	if typeof(root) != TYPE_ARRAY:
		push_error("Problem bank root must be an array: %s" % path)
		return []
	var problems: Array[Problem] = []
	for entry in root:
		if typeof(entry) != TYPE_DICTIONARY:
			push_error("Skipping non-dictionary entry in %s" % path)
			continue
		problems.append(Problem.from_dict(entry))
	return problems
