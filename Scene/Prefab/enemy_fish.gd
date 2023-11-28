extends EnemyInterface

class_name  FishEnemy

@export var hp : float = 10
@export var speed : float = 100
@export var atk : int = 1
	

func _process(delta):
	self.position.x -= speed * delta

func damage():
	pass

func damaged(amount: float):
	hp -= amount
	show_damage(amount)
	if (hp <= 0):
		queue_free()
	
func show_damage(amount: int):
	var damage_number = preload("res://Scene/Prefab/floating_number.tscn").instantiate()
	add_sibling(damage_number)
	damage_number.global_position = global_position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
	damage_number.start(str(amount))

	
func remove():
	queue_free()


func _on_area_2d_area_entered(area):
	print('ouch')
	if area.is_in_group("Lazer"):
		damaged(area.owner.get_damage())
