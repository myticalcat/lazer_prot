extends Node2D

@export var lazer_render : LazerRenderer
@export var spawners : Array[EnemySpawner]
@export var lable_score : Label
var score : int = 0
var level : int = 1
func _ready():
	$GameOver.set_process(false)
	$GameOver.visible = false
	connect("killed_fish", _on_killed)
	for spawner in spawners:
		spawner.connect("enemy_killed", _on_killed)
		
	$Music.play()

func _on_killed():
	score += 10
	lable_score.text = "points: " + str(score)

func _on_lazer_renderer_dead_signal():
	$LazerRenderer.queue_free()
	$EnemyTimer.queue_free()
	for spawner in spawners:
		spawner.queue_free()
	
	$GameOver.set_process(true)
	$Music.stop()
	$SadTrumpet.play()
	$GameOver.visible = true

func _on_game_over_restart_game():
	get_tree().reload_current_scene()

func _on_shop_buy_cooldown():
	if(score < 100):
		spawn_cant_buy()
		return
	score -= 100
	$Shop.level_up_cd()
	lable_score.text = "points: " + str(score)
	lazer_render.low_cooldown()

func _on_shop_buy_damage():
	if(score < 100):
		spawn_cant_buy()
		return
	score -= 100
	$Shop.level_up_atk()
	lable_score.text = "points: " + str(score)
	lazer_render.add_damage()

func _on_shop_buy_health():
	if(score < 50):
		spawn_cant_buy()
		return
	score -= 50
	lable_score.text = "points: " + str(score)
	lazer_render.restore_hp()

func spawn_cant_buy():
	var damage_number = preload("res://Scene/Prefab/floating_number.tscn").instantiate()
	add_sibling(damage_number)
	damage_number.global_position = get_global_mouse_position() + Vector2(randi_range(-10, 10), randi_range(-10, 10))
	damage_number.start("not enough points :(")

func _on_timer_timeout():
	for spawner in spawners:
		spawner._on_spawn_timer_timeout()


func _on_lazer_renderer_max_cd():
	$Shop.disable_cd()


func _on_lazer_renderer_max_damage():
	$Shop.disable_atk()


func _on_level_timer_timeout():
	level += 1
	$LVL.text = "Level - " + str(level)
	$EnemyTimer.wait_time -= 1
	if $EnemyTimer.wait_time < 1:
		$EnemyTimer.wait_time = 1
	if level % 5 != 0:
		return
	for spawner in spawners:
		spawner.chance += 0.2
		if spawner.chance >= 1:
			spawner.chance = 1
