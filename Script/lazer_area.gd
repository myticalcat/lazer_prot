extends CollisionShape2D

var is_mouse_in = false
var is_lazer_crt = false
var start_pos = Vector2()
var end_pos = Vector2()
var lazer_prefab = preload("res://Scene/Prefab/lazer.tscn")
var lazer : Node2D = null

func _process(delta):
	check_to_fire(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT))
	if not is_instance_valid(lazer):
		lazer = null
		

func check_to_fire(mouse_down : bool):
	if mouse_down and is_mouse_in:
		if not is_lazer_crt and lazer == null:
			is_lazer_crt = true
			start_pos = get_global_mouse_position() - get_parent().position
			lazer = lazer_prefab.instantiate()
			lazer.position = start_pos
			add_sibling(lazer)
			return
		elif is_lazer_crt:
			update_lazer_scale()
	elif mouse_down and not is_mouse_in:
		is_lazer_crt = false
		if lazer:
			lazer.queue_free()
			lazer = null
	elif is_lazer_crt:
		is_lazer_crt = false
		fire_lazer()

func update_lazer_scale():
	var current_mouse_pos = get_global_mouse_position()
	if(current_mouse_pos.x < start_pos.x) :
		lazer.position.x = current_mouse_pos.x 
	if(current_mouse_pos.y < start_pos.y) :
		lazer.position.y = current_mouse_pos.y
	lazer.scale.x = abs(current_mouse_pos.x - start_pos.x)
	lazer.scale.y = abs(current_mouse_pos.y - start_pos.y)

func fire_lazer():
	if lazer:
		lazer.start_lazering()
	start_pos = Vector2()
	end_pos = Vector2()

func start_cooldown():
	print('starting cooldown')

func _on_area_2d_mouse_entered():
	is_mouse_in = true

func _on_area_2d_mouse_exited():
	is_mouse_in = false
