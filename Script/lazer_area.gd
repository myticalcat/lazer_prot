extends CollisionShape2D

var is_mouse_in = false
var is_lazer_crt = false
var start_pos = Vector2()
var end_pos = Vector2()
var lazer_prefab = preload("res://Scene/Prefab/lazer.tscn")
var lazer : Node2D = null

func _process(delta):
	var is_button_pressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if is_button_pressed and is_mouse_in:
		if not is_lazer_crt:
			is_lazer_crt = true
			start_pos = get_global_mouse_position() - get_parent().position
			lazer = lazer_prefab.instantiate()
			lazer.position = start_pos
			add_sibling(lazer)
			return
		update_lazer_scale()
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

func _on_area_2d_mouse_entered():
	is_mouse_in = true

func _on_area_2d_mouse_exited():
	is_mouse_in = false
