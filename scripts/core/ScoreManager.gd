extends Node
class_name ScoreManager

signal score_changed

var score: int = 0
var attempts: int = 0
var correct_answers: int = 0
var streak: int = 0
var time_remaining: float = 0.0

func configure_time(limit: float) -> void:
	time_remaining = limit
	emit_signal("score_changed")

func tick(delta: float) -> void:
	time_remaining = max(0.0, time_remaining - delta)
	emit_signal("score_changed")

func record_attempt(correct: bool) -> void:
	attempts += 1
	if correct:
		correct_answers += 1
		streak += 1
		score += 100 + (streak * 10)
	else:
		streak = 0
	emit_signal("score_changed")

func accuracy() -> float:
	if attempts == 0:
		return 0.0
	return float(correct_answers) / float(attempts)
