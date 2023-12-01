extends ProgressBar

class_name HPBar

func update(currHp : float):
	self.value = currHp
	
	if value == 0 :
		$Label.text = ""
		return
	$Label.text = str(int(value)) + "%"
