extends CanvasLayer

enum state {
	READY,
	READING,
	FINISHED
}


const CHAR_READ_RATE = 0.07

var current_state: int
var _tween: Tween

@onready var _text = %Text


func _ready():
	%Text.visible_ratio = 0.0


func show_textbox():
	show()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if current_state == state.FINISHED:
			_change_state(state.READY)
		elif current_state == state.READING:
			_change_state(state.FINISHED)


func _change_state(new_state):
	current_state = new_state
	match current_state:
		state.READY:
			_text.visible_ratio = 0.0
		state.READING:
			_tween.play()
		state.FINISHED:
			_text.visible_ratio = 1.0
			_tween.pause()


func set_text(text) -> void:
	_text.text = text
	show_textbox()
	_tween = create_tween()
	_tween.tween_property(_text, "visible_ratio", 1.0, len(text) * CHAR_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	_tween.connect("finished", _on_tween_finished)
	_change_state(state.READING)


# Manages signal received from tween finishing

func _on_tween_finished() -> void:
	_change_state(state.FINISHED)
