extends Control


@onready var grid: Control = $HBox/Grid
@onready var arrow: Control = $HBox/Grid/VectorArrow2D
@onready var calc: Control = $HBox/UI/CalculatorPanel
@onready var feedback: Label = $HBox/UI/Feedback
@onready var next_button: Button = $HBox/UI/NextButton

var problems: Array[Problem] = []
var index: int = 0

func _ready() -> void:
	problems = ProblemLoader.load_problem_bank("res://data/levels/vector_components_easy.json")
	calc.vector_submitted.connect(_on_vector_submitted)
	next_button.pressed.connect(_next_problem)
	_show_problem()

func _show_problem() -> void:
	if problems.is_empty():
		feedback.text = "No problems loaded."
		return
	var p: Problem = problems[index]
	var center := grid.size * 0.5
	var target_screen := center + Vector2(p.target_vector.x * 24.0, -p.target_vector.y * 24.0)
	arrow.start_point = center
	arrow.end_point = target_screen
	arrow.draw_components = true
	arrow.label = "target"
	arrow.queue_redraw()
	feedback.text = p.prompt

func _on_vector_submitted(v: Vector2) -> void:
	var p: Problem = problems[index]
	var correct: bool = Vector2Math.approx_equal_vec2(v, p.target_vector, p.tolerance)
	var err: Vector2 = Vector2Math.component_error(v, p.target_vector)
	var polar := CoordinateSystems.cartesian_to_polar(p.target_vector)
	feedback.text = "Submitted %s | Correct %s | Error %s | |v|=%.2f, θ=%.1f° => %s" % [v, p.target_vector, err, polar["magnitude"], polar["angle_degrees"], ("Correct" if correct else "Try again")]

func _next_problem() -> void:
	if problems.is_empty():
		return
	index = (index + 1) % problems.size()
	_show_problem()
