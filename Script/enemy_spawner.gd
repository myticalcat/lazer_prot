extends Node2D

var enemy_list : Array[PackedScene] = [
	preload("res://Scene/Prefab/enemy_fish.tscn"),
]

var spawn_timer : float = 2.0  # Adjust the time between spawns
var spawn_timer_max : float = 5  # Maximum time between spawns
var spawn_area : Rect2 = Rect2(Vector2(0, 0), Vector2(800, 600))  # Adjust the spawn area
var chance : float = 0.2
func _process(delta):
	spawn_timer -= delta

	if spawn_timer <= 0.0 and randf() < chance:
		spawn_enemy()
		spawn_timer = randf() * spawn_timer_max


func spawn_enemy():
	if enemy_list.size() == 0:
		return

	var random_index = randi() % enemy_list.size()
	var enemy_scene = enemy_list[random_index]
	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)

