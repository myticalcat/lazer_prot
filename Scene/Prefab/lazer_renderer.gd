extends Node2D

signal dead_signal


func _on_collision_shape_2d_dead():
	emit_signal("dead_signal")
