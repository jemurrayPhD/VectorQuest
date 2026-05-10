extends LineEdit
class_name NumericEntry

func as_float() -> Variant:
	if text.strip_edges() == "":
		return null
	if not text.is_valid_float():
		return null
	return float(text)
