extends EnemyInterface

class_name  FishEnemy

@export var hp : int = 10
@export var speed : float = 1
@export var atk : int = 1
	

func _process(delta):
	self.position.x -= speed

func damage():
	pass

func damaged(amount : int):
	pass
	
func remove():
	queue_free()
