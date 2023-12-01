extends Node2D
@export var lazer_rect: ColorRect

var lazer_duration = 10
var damage  = 10
func start_lazering(animator : AnimationPlayer):
	print('imma firin my lazeeeeer')
	await flicker(lazer_rect, 0.1, lazer_duration)
	$LazerSound.play()
	await fire(lazer_rect)
	queue_free()

func flicker(obj: ColorRect, initial_interval: float, duration: float, decay_factor: float = 0.9):
	var end_time = Time.get_ticks_msec() + duration * 1000 
	var current_interval = initial_interval

	while Time.get_ticks_msec() < end_time:
		obj.visible = !obj.visible
		await get_tree().create_timer(current_interval).timeout
		
		current_interval *= decay_factor
		if current_interval < 0.01:
			current_interval = 0.01

	obj.visible = true
	
func fire(obj: ColorRect):
	
	obj.scale.x = 1000
	var duration = 500 
	var current_interval = 0.01 
	var steps = duration / (current_interval * 1000) 
	var fade_step = obj.color.a / steps

	while obj.color.a > 0:
		obj.color.a -= fade_step
		if obj.color.a < 0:
			obj.color.a = 0
		await get_tree().create_timer(current_interval).timeout


func get_damage() -> float:
	var area = log(scale.y)**2 / 10
	if area < 1:
		area = 1
		print(area)
	return damage / area


func _on_timer_timeout():
	queue_free()
