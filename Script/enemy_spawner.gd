extends Node2D

var enemy_list: Array[PackedScene] = [
	preload("res://Scene/Prefab/enemy_fish.tscn"),
]

var chance: float = 0.2 

func _ready():
	randomize()

func spawn_enemy() -> void:
	if enemy_list.size() == 0:
		return
	var random_index = randi() % enemy_list.size()
	var enemy_scene = enemy_list[random_index]
	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)
	enemy_instance.position.y += randi_range(-100, 100)


func _on_spawn_timer_timeout():
	var number = randf()
	if number < chance:
		spawn_enemy()
