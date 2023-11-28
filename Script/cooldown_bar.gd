extends ProgressBar

class_name CooldownProgress
@export var text_label : Label

func update(cooldown_timer : float, cooldown_duration : float):
	self.value = cooldown_timer * 100 / cooldown_duration
	
	if value == 0 :
		text_label.text = ""
		return
	text_label.text = str(int(value)) + "%"

func start_cooldown():
	var duration = 500 
	var current_interval = 0.01 
	var steps = duration / (current_interval * 1000) 
	var fade_step = 100 / steps

	while value < 100:
		value += fade_step
		if value > 100:
			value = 100
		await get_tree().create_timer(current_interval).timeout
	
