extends CollisionShape2D

var is_mouse_in = false
var is_lazer_crt = false
var start_pos = Vector2()
var end_pos = Vector2()
var lazer_prefab = preload("res://Scene/Prefab/lazer.tscn")
var cooldown_duration = 0.1
var cooldown_timer = 0.0
var lazer_duration = 0.1
var lazer : Node2D = null
var is_cooling_down = false
var hp = 100
@export var cooldown_bar : CooldownProgress
@export var HP_bar : HPBar
@export var animator : AnimationPlayer
signal dead
var play_hold
var play_cast
func _ready():
	animator.play("idle")
	HP_bar.update(hp)

func _process(delta):

	
	if(lazer == null):
		cooldown_timer -= delta
	if(is_cooling_down):
		cooldown_timer += 0.1
		if(cooldown_timer >= cooldown_duration):
			is_cooling_down = false
			cooldown_timer = cooldown_duration
	cooldown_bar.update(cooldown_timer, cooldown_duration)
	check_to_fire(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT))

	if not is_instance_valid(lazer):
		lazer = null
		
	if(lazer != null and play_hold):
		
		animator.play("hold")
	elif(play_cast):
		animator.play("cast")
		if(animator.get_current_animation_position() >= 0.99):
			play_hold = true
			print("here")
	else:
		animator.play("idle")

func check_to_fire(mouse_down: bool):
	if cooldown_timer > 0.0:
		if mouse_down:
			var damage_number = preload("res://Scene/Prefab/floating_number.tscn").instantiate()
			add_sibling(damage_number)
			damage_number.global_position = get_global_mouse_position() + Vector2(randi_range(-10, 10), randi_range(-10, 10))
			damage_number.start("cooling down!", 5)
		return
	if not mouse_down:
		if is_lazer_crt:
			is_lazer_crt = false
			fire_lazer()
			start_cooldown()
		return

	if is_mouse_in:
		if not is_lazer_crt:
			play_cast = true
			is_lazer_crt = true
			start_pos = get_global_mouse_position() - get_parent().position
			lazer = lazer_prefab.instantiate()
			lazer.lazer_duration = lazer_duration
			lazer.position = start_pos
			add_sibling(lazer)
		elif is_lazer_crt:
			update_lazer_scale()
	else:
		is_lazer_crt = false
		if lazer:
			lazer.queue_free()
			lazer = null

func update_lazer_scale():
	var current_mouse_pos = get_global_mouse_position()
	if(current_mouse_pos.x < start_pos.x):
		lazer.position.x = current_mouse_pos.x
	if(current_mouse_pos.y < start_pos.y):
		lazer.position.y = current_mouse_pos.y
	lazer.scale.x = abs(current_mouse_pos.x - start_pos.x)
	lazer.scale.y = abs(current_mouse_pos.y - start_pos.y)

func fire_lazer():
	if lazer:
		lazer.start_lazering(animator)
	start_pos = Vector2()
	end_pos = Vector2()
	play_cast = false
	play_hold = false

func start_cooldown():
	is_cooling_down = true
	

func _on_area_2d_mouse_entered():
	is_mouse_in = true

func _on_area_2d_mouse_exited():
	is_mouse_in = false

func damaged(damage : float):
	hp -= damage
	if(hp <= 0):
		hp = 0
		print('dead1')
		emit_signal('dead')
	HP_bar.update(hp)

func _on_danger_zone_area_entered(area):
	damaged(area.owner.atk)
	area.owner.queue_free()
