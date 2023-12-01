extends Sprite2D


var is_open : bool = false

func _ready():
	$AnimationPlayer.play("close")
	is_open = false
	$TextureButton.flip_v = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	if is_open:
		$AnimationPlayer.play("close")
		is_open = false
		$TextureButton.flip_v = true
	else:
		$AnimationPlayer.play("open")
		is_open = true
		$TextureButton.flip_v = false
