extends ProgressBar

class_name HPBar
# Called when the node enters the scene tree for the first time.
func update(currHp : float):
	self.value = currHp
	
	if value == 0 :
		$Label.text = ""
		return
	$Label.text = str(int(value)) + "%"
