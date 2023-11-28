extends Control

signal restart_game


func _on_button_pressed():
	emit_signal('restart_game')
