extends CanvasLayer

var label_text = "Time before it: "
@export var time_label: Label
@export var timer = Timer


func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]

func _process(delta):
	time_label.text = label_text + format_time(timer.time_left)
