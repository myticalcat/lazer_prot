extends Node2D

class_name LazerRenderer

signal dead_signal
signal max_damage
signal max_cd
@export var area : LazerArea

func _on_collision_shape_2d_dead():
	emit_signal("dead_signal")

func add_damage():
	area.lazer_damage += 10
	if area.lazer_damage >= 100:
		area.lazer_damage = 100
		emit_signal("max_damage")
	
func low_cooldown():
	area.cooldown_duration /= 1.2
	if area.cooldown_duration < 0.2:
		emit_signal('max_cd')

func restore_hp():
	area.hp = 100
	area.update_hp()
