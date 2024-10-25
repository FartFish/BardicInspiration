@tool
class_name SpellBehaviorChangeObjSprite extends SpellBehaviorGetComplexPoints

@export var new_texture:Texture2D
@export var layer:String = "unit"


func handle(caster:GameObject, point:Vector2i, source = null):
	var obj = GameManager.level.tiles[point.x][point.y].get(layer)
	if obj:
		obj.texture = new_texture
