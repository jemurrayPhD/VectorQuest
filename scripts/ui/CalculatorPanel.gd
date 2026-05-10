extends PanelContainer
class_name CalculatorPanel

signal vector_submitted(vector: Vector2)

@onready var input_widget: VectorInputWidget = $Margin/VBox/VectorInputWidget

func _ready() -> void:
	input_widget.vector_submitted.connect(func(v: Vector2): emit_signal("vector_submitted", v))
