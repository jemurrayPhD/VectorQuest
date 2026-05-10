extends VBoxContainer
class_name VectorInputWidget

signal vector_submitted(vector: Vector2)

@onready var mode_button: Button = $ModeButton
@onready var a_entry: LineEdit = $EntryRow/AEntry
@onready var b_entry: LineEdit = $EntryRow/BEntry
@onready var submit_button: Button = $SubmitButton

var use_polar: bool = false

func _ready() -> void:
	mode_button.pressed.connect(_toggle_mode)
	submit_button.pressed.connect(_submit)
	a_entry.text_submitted.connect(_on_enter)
	b_entry.text_submitted.connect(_on_enter)
	_refresh_labels()

func _on_enter(_text: String) -> void:
	_submit()

func _toggle_mode() -> void:
	use_polar = not use_polar
	_refresh_labels()

func _refresh_labels() -> void:
	if use_polar:
		mode_button.text = "Mode: Polar"
		a_entry.placeholder_text = "Magnitude"
		b_entry.placeholder_text = "Angle °"
	else:
		mode_button.text = "Mode: Cartesian"
		a_entry.placeholder_text = "vx"
		b_entry.placeholder_text = "vy"

func _submit() -> void:
	if not a_entry.text.is_valid_float() or not b_entry.text.is_valid_float():
		return
	var a: float = float(a_entry.text)
	var b: float = float(b_entry.text)
	var output: Vector2 = Vector2(a, b)
	if use_polar:
		output = Vector2(cos(deg_to_rad(b)), sin(deg_to_rad(b))) * a
	emit_signal("vector_submitted", output)
