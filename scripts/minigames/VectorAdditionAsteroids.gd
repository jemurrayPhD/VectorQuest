extends Control

const ProblemLoader = preload("res://scripts/core/ProblemLoader.gd")
const Vector2Math = preload("res://scripts/math/Vector2Math.gd")
const DifficultyManager = preload("res://scripts/core/DifficultyManager.gd")

@onready var arena: Control = $HBox/Arena
@onready var calc: Control = $HBox/UI/CalculatorPanel
@onready var feedback: Label = $HBox/UI/Feedback
@onready var score_label: Label = $HBox/UI/Score
@onready var timer_label: Label = $HBox/UI/Timer

var problems: Array = []
var index: int = 0
var score_manager: ScoreManager
var submitted_vector: Vector2 = Vector2.ZERO

func _ready() -> void:
	problems = ProblemLoader.load_problem_bank("res://data/levels/asteroids_vectors_easy.json")
	score_manager = ScoreManager.new()
	add_child(score_manager)
	score_manager.score_changed.connect(_refresh_score)
	score_manager.configure_time(DifficultyManager.get_preset("easy")["time_limit"])
	calc.vector_submitted.connect(_on_submit)
	_refresh_score()
	queue_redraw()

func _process(delta: float) -> void:
	score_manager.tick(delta)

func _draw() -> void:
	if problems.is_empty():
		return
	var center := arena.position + (arena.size * 0.5)
	draw_circle(center, 8.0, Color.DEEP_SKY_BLUE)
	var target := problems[index].target_vector
	var target_screen := center + Vector2(target.x * 24.0, -target.y * 24.0)
	draw_rect(Rect2(target_screen - Vector2(10, 10), Vector2(20, 20)), Color(0.8, 0.5, 0.3))
	var end := center + Vector2(submitted_vector.x * 24.0, -submitted_vector.y * 24.0)
	draw_line(center, end, Color.GREEN_YELLOW, 3.0)

func _on_submit(v: Vector2) -> void:
	if problems.is_empty():
		return
	submitted_vector = v
	var target: Vector2 = problems[index].target_vector
	var hit: bool = Vector2Math.distance(v, target) <= problems[index].tolerance
	score_manager.record_attempt(hit)
	feedback.text = ("HIT" if hit else "MISS") + " submitted=%s target=%s" % [v, target]
	if hit:
		index = (index + 1) % problems.size()
	queue_redraw()

func _refresh_score() -> void:
	score_label.text = "Score: %d  Streak: %d  Acc: %.0f%%" % [score_manager.score, score_manager.streak, score_manager.accuracy() * 100.0]
	timer_label.text = "Time: %.1f" % score_manager.time_remaining
