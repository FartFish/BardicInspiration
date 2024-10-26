@tool
class_name SpellBehavior extends Resource

@export var display:bool = true
@export var sounds:Array[String] = []

func handle(caster:GameObject, point:Vector2i, source = null):
	for sound in sounds:
		#AudioManager.playsound(sound)
		pass

func can_cast(caster:GameObject, point:Vector2i) -> bool:
	return true

func get_impacted_points(caster:GameObject, point:Vector2i, source = null):
	return [point]

func get_impacted_tiles(caster:GameObject, point:Vector2i, source = null):
	var tiles = []
	
	for p in get_impacted_points(caster, point):
		if p.x > 0 and p.x < GameManager.level.tiles.size() and p.y > 0 and p.y < GameManager.level.tiles[0].size():
			tiles.append(GameManager.level.tiles[p.x][p.y])
	
	return tiles

func get_description() -> String:
	return ""

func _get_icon() -> Image:
	var icon = GradientTexture2D.new()
	
	var gradient_data := {
		0.0 : Color(0, 0, 0)
	}
	
	var gradient = Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	
	icon.gradient = gradient
	
	return icon.get_image()
