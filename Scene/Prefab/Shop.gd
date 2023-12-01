extends Sprite2D


var is_open : bool = false
signal buy_health
signal buy_cooldown
signal buy_damage
var lvl_atk = 1
var lvl_cd = 1
func _ready():
	# $AnimationPlayer.play("close")
	is_open = false
	$TextureButton.flip_v = true

func _on_texture_button_pressed():
	if is_open:
		$AnimationPlayer.play("close")
		is_open = false
		$TextureButton.flip_v = true
	else:
		$AnimationPlayer.play("open")
		is_open = true
		$TextureButton.flip_v = false


func _on_atk_button_pressed():
	emit_signal("buy_damage")

func level_up_atk():
	lvl_atk += 1
	$AtkLabel.text = "LVL " + str(lvl_atk)


func _on_cd_button_pressed():
	emit_signal("buy_cooldown")
	
func level_up_cd():
	lvl_cd += 1
	$CdLabel.text = "LVL " + str(lvl_cd)

func _on_heal_button_pressed():
	emit_signal("buy_health")
	
func disable_atk():
	$AtkButton.disabled = true
	$AtkLabel.text = "LVL MAX"

func disable_cd():
	$CdButton.disabled = true
	$CdLabel.text = "LVL MAX"
