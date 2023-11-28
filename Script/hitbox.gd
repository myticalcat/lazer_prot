extends Area2D

class_name Hitbox

func _init():
	collision_layer = 2
	collision_mask = 0

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox : Hitbox):
	if hitbox == null:
		return
		
	if owner.has_method("damaged"):
		owner.damaged(hitbox.damage)
