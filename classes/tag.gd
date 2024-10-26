@tool
class_name Tag extends Resource

@export var name = "Tag"
@export var id = "tag"
@export var color:Color

func _get_icon() -> Image:
	var icon = GradientTexture2D.new()
	
	var gradient_data := {
		0.0 : color
	}
	
	var gradient = Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	
	icon.gradient = gradient
	
	return icon.get_image()
