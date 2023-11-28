extends Node2D

var fade_out_duration = 1.0
var move_distance = Vector2(0, -50)

func start(text : String):
	$Label.text = str(text)
	$Label.add_theme_font_size_override("font_size", 24)
	animate()

func animate():
	var tween: = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Label, "position",$Label.position + move_distance, fade_out_duration)
	tween.tween_property($Label, "modulate", Color(1,0,0,0), fade_out_duration)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	queue_free()
