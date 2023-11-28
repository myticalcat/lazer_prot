extends Node2D



func _ready():
	$GameOver.set_process(false)
	$GameOver.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_lazer_renderer_dead_signal():
	$GameOver.set_process(true)
	$GameOver.visible = true


func _on_game_over_restart_game():
	get_tree().reload_current_scene()
